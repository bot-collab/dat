(function() {
var DateFormatter = ASPx.CreateClass(null, {
 constructor: function() {
  this.date = new Date(2000, 0, 1);
  this.mask;
  this.specifiers = {};     
  this.spPositions = [];    
  this.knownSpecifiers = ["d", "M", "y", "H", "h", "m", "s", "f", "F", "g", "t"];
  this.savedYear = -1;
  this.isYearParsed = false;
  this.parsedMonth = -1;
  this.replacers = {
   "d": this.ReplaceDay,
   "M": this.ReplaceMonth,
   "y": this.ReplaceYear,
   "H": this.ReplaceHours23,
   "h": this.ReplaceHours12,
   "m": this.ReplaceMinutes,
   "s": this.ReplaceSeconds,
   "F": this.ReplaceMsTrimmed,
   "f": this.ReplaceMs,
   "g": this.ReplaceEra,
   "t": this.ReplaceAmPm
  };
  this.parsers = {
   "d": this.ParseDay,
   "M": this.ParseMonth,
   "y": this.ParseYear,
   "H": this.ParseHours,
   "h": this.ParseHours,
   "m": this.ParseMinutes,
   "s": this.ParseSeconds,
   "F": this.ParseMs,
   "f": this.ParseMs,
   "g": this.ParseEra,
   "t": this.ParseAmPm
  };
 },
 Format: function(date) {
  this.date = date;
  var sp;
  var pos;
  var replacerKey;
  var result = this.mask;
  for(var i = 0; i < this.spPositions.length; i++) {
   pos = this.spPositions[i];
   sp = this.specifiers[pos];
   replacerKey = sp.substr(0, 1);
   if(this.replacers[replacerKey]) {
    result = result.substr(0, pos) + this.replacers[replacerKey].call(this, sp.length) + result.substr(pos + sp.length);
   }
  }
  return result;
 }, 
 Parse: function(str) {
  var now = new Date();  
  this.savedYear = now.getFullYear();
  this.isYearParsed = false;
  this.parsedMonth = -1;
  this.date = new Date(2000, 0, now.getDate());    
  this.strToParse = str;
  this.catchNumbers(str);  
  var parserKey;
  var sp;
  var pos;
  var parseResult;
  var error = false;
  this.hasAmPm = false;
  for(var i = 0; i < this.spPositions.length; i++) {
   pos = this.spPositions[i];
   sp = this.specifiers[pos];
   parserKey = sp.substr(0, 1);
   if(this.parsers[parserKey]) {
    parseResult = this.parsers[parserKey].call(this, sp.length);
    if(!parseResult) {
     error = true;
     break;
    }
   }
  }
  if(error)
   return false;
  if(this.hasAmPm) {
   if(!this.fixHours())
    return false;
  }
  if(!this.isYearParsed)
   this.date.setYear(this.savedYear);
  if(this.parsedMonth < 0)
   this.parsedMonth = now.getMonth();   
  this.ApplyMonth();
  return this.date;  
 },
 ApplyMonth: function() {
  var trial;
  var day = this.date.getDate();
  while(true) {
   trial = new Date();
   trial.setTime(this.date.getTime());   
   trial.setMonth(this.parsedMonth);
   if(trial.getMonth() == this.parsedMonth)
    break;
   --day;
   this.date.setDate(day);
  }
  ASPx.DateUtils.FixTimezoneGap(this.date, trial);
  this.date = trial;
 },
 SetFormatString: function(mask) {
  if(mask.length == 2 && mask.charAt(0) == "%")
   mask = mask.charAt(1);
  this.specifiers = {}; 
  this.spPositions = [];
  this.mask = "";
  var subt = 0;
  var pos = 0;
  var startPos = 0;
  var ch;
  var prevCh = "";
  var skip = false;
  var backslash = false;
  var sp = "";    
  while(true) {
   ch = mask.charAt(pos);
   if(ch == "") {
    if(sp.length > 0)
     this.RegisterSpecifier(startPos, sp);
    break;
   }
   if(ch == "\\" && !backslash) {
    backslash = true;
    subt++;
   } else {
    if(!backslash && (ch == "'" || ch == '"')) {
     skip = !skip;
     subt++;
    } else {     
     if(!skip) {
      if(ch == "/")
       ch = ASPx.CultureInfo.ds;       
      else if(ch == ":")
       ch = ASPx.CultureInfo.ts;
      else if(this.IsKnownSpecifier(ch)) {
       if(prevCh.length == 0)
        prevCh = ch;
       if(ch == prevCh)
        sp += ch;
       else {
        if(sp.length > 0)
         this.RegisterSpecifier(startPos, sp);
        sp = ch;
        startPos = pos - subt;
       }
      }
     }     
     this.mask += ch;
    }      
    backslash = false;
   }            
   prevCh = ch;
   pos++;
  }
  this.spPositions.reverse();
 },
 RegisterSpecifier: function(pos, sp) {
  this.spPositions.push(pos);
  this.specifiers[pos] = sp; 
 },
 ReplaceDay: function(length) {
  if(length < 3) {
   var value = this.date.getDate().toString();
   return length == 2 ? this.padLeft(value, 2) : value;  
  } else if(length == 3) {
   return ASPx.CultureInfo.abbrDayNames[this.date.getDay()];
  } else {
   return ASPx.CultureInfo.dayNames[this.date.getDay()];
  }
 }, 
 ReplaceMonth: function(length) {
  var value = 1 + this.date.getMonth();
  switch(length) {
   case 1:
    return value.toString();
   case 2:
    return this.padLeft(value.toString(), 2);
   case 3:
    return ASPx.CultureInfo.abbrMonthNames[value - 1];
   default:
    for(var i in this.specifiers) {
     var spec = this.specifiers[i];
     if(spec == "d" || spec == "dd")
      return ASPx.CultureInfo.genMonthNames[value - 1];
  }
    return ASPx.CultureInfo.monthNames[value - 1];
  }
 },
 ReplaceYear: function(length) {
  var value = this.date.getFullYear();
  if(length <= 2)
   value = value % 100;
  return this.padLeft(value.toString(), length);
 },
 ReplaceHours23: function(length) {
  var value = this.date.getHours().toString();
  return length > 1 ? this.padLeft(value, 2) : value;
 },
 ReplaceHours12: function(length) {
  var value = this.date.getHours() % 12;
  if(value == 0)
   value = 12;
  value = value.toString();
  return length > 1 ? this.padLeft(value, 2) : value;
 },
 ReplaceMinutes: function(length) {
  var value = this.date.getMinutes().toString();
  return length > 1 ? this.padLeft(value, 2) : value;
 },
 ReplaceSeconds: function(length) {
  var value = this.date.getSeconds().toString();
  return length > 1 ? this.padLeft(value, 2) : value;
 },
 ReplaceMsTrimmed: function(length) {   
  return this.formatMs(length, true);
 },
 ReplaceMs: function(length) { 
  return this.formatMs(length, false);
 },
 ReplaceEra: function(length) {
  return "A.D.";
 },
 ReplaceAmPm: function(length) {
  var value = this.date.getHours() < 12 ? ASPx.CultureInfo.am : ASPx.CultureInfo.pm;
  return length < 2 ? value.charAt(0) : value;
 },
 catchNumbers: function(str) {
  this.parseNumbers = [];  
  var regex = /\d+/g;  
  var match;
  for(;;) {
   match = regex.exec(str);
   if(!match)
    break;
   this.parseNumbers.push(this.parseDecInt(match[0]));
  }  
  var spCount = 0;
  var now = new Date();
  for(var i in this.specifiers) {
   var sp = this.specifiers[i];
   if(sp.constructor != String || !this.IsNumericSpecifier(sp)) continue;
   spCount++;
   if(this.parseNumbers.length < spCount) {    
    var defaultValue = 0;
    if(sp.charAt(0) == "y") defaultValue = now.getFullYear(); 
    this.parseNumbers.push(defaultValue);
   }
  }
  var excess = this.parseNumbers.length - spCount;
  if(excess > 0)
   this.parseNumbers.splice(spCount, excess);  
  this.currentParseNumber = this.parseNumbers.length - 1;
 },
 popParseNumber: function() {
  return this.parseNumbers[this.currentParseNumber--];
 },
 findAbbrMonth: function() {
  return this.findMonthCore(ASPx.CultureInfo.abbrMonthNames);
 },
 findFullMonth: function() {
  return this.findMonthCore(ASPx.CultureInfo.genMonthNames);
 }, 
 findMonthCore: function(monthNames) {
  var inputLower = this.strToParse.toLowerCase();
  for(var i = 0; i < monthNames.length; i++) {
   var monthName = monthNames[i].toLowerCase();
   if(monthName.length > 0 &&  inputLower.indexOf(monthName) > -1) {
    var empty = "";
    for(var j = 0; j < monthName.length; j++) empty += " ";
    this.strToParse = this.strToParse.replace(new RegExp(monthName, "gi"), empty);
    return 1 + parseInt(i);
   }
  }
  return false;
 },
 ParseDay: function(length) {
  if(length < 3) {
   var value = this.popParseNumber();
   if(value < 1 || value > 31)
    return false;
   this.date.setDate(value);
  }
  return true;
 },
 ParseMonth: function(length) {
  var value;
  switch(length){
   case 1:
   case 2:
    value = this.popParseNumber();
    break; 
   case 3:
    value = this.findAbbrMonth();
    break;
   default:
    value = this.findFullMonth();
    break;
  }
  if(value < 1 || value > 12)
   return false;
  this.parsedMonth = value - 1;
  return true;
 }, 
 ParseYear: function(length) {  
  var value = this.popParseNumber();
  if(value > 9999)
   return false;
  if(value < 100)
   value = ASPx.DateUtils.ExpandTwoDigitYear(value);
  this.date.setFullYear(value);
  this.isYearParsed = true;
  return true;
 },
 ParseHours: function(length) {
  var value = this.popParseNumber();
  if(value > 23)
   return false;
  this.date.setHours(value);
  return true;
 },
 ParseMinutes: function(length) {
  var value = this.parseMinSecCore();
  if(value == -1)
   return false;
  this.date.setMinutes(value);
  return true;
 },
 ParseSeconds: function(length) {
  var value = this.parseMinSecCore();
  if(value == -1)
   return false;
  this.date.setSeconds(value);
  return true;
 },
 ParseMs: function(length) {
  if(length > 3)
   length = 3;
  var thr = 1;
  for(var i = 0; i < length; i++)
   thr *= 10;
  thr -= 1;
  var value = this.popParseNumber();
  while(value > thr)
   value /= 10;
  this.date.setMilliseconds(Math.round(value));
  return true;
 },
 ParseEra: function(length) {
  return true;
 },
 ParseAmPm: function(length) {
  this.hasAmPm = ASPx.CultureInfo.am.length > 0 && ASPx.CultureInfo.pm.length > 0;
  return true;
 },
 parseDecInt: function(str) {
  return parseInt(str, 10);
 },
 padLeft: function(str, length) {
  while(str.length < length)
   str = "0" + str;
  return str;
 },
 formatMs: function(length, trim) {
  var value = Math.floor(this.date.getMilliseconds() * Math.pow(10, length - 3));
  value = this.padLeft(value.toString(), length);    
  if(trim) {
   var pos = value.length - 1;
   var req = false;
   while(value.charAt(pos) == "0") {
    req = true;
    pos--;
   }
   if(req)
    value = value.substring(0, pos + 1);   
  }
  return value;
 },
 parseMinSecCore: function() {
  var value = this.popParseNumber();
  return value > 59 ? -1 : value;
 },
 fixHours: function() {
  var state = this.getAmPmState(this.strToParse);
  if(!state) return true;
  var h = this.date.getHours();
  switch(state) {
   case "P":
    if(h > 12) return false;
    if(h < 12)
     this.date.setHours(12 + h);
    break;
   case "A":
    if(h == 12)
     this.date.setHours(0);
  }
  return true;
 },
 getAmPmState: function(str, skipCorrection) {
  var am = ASPx.CultureInfo.am.charAt(0).toLowerCase();
  var pm = ASPx.CultureInfo.pm.charAt(0).toLowerCase();
  var amMatches = new RegExp(am, "gi").exec(str);
  var pmMatches = new RegExp(pm, "gi").exec(str);
  var amCount = amMatches ? amMatches.length : 0;
  var pmCount = pmMatches ? pmMatches.length : 0;
  var hasAm = amCount > 0;
  var hasPm = pmCount > 0;
  if(hasAm ^ hasPm && amCount < 2 && pmCount < 2)
   return hasAm ? "A" : "P";
  if(!skipCorrection) {
   str = str.replace(new RegExp(this.getDayMonthNameReplacePattern(), "gi"), "");
   return this.getAmPmState(str, true);
  }
  return null;
 },
 getDayMonthNameReplacePattern: function() {
  if(!this.dayMonthNameReplacePattern)
   return this.createDayMonthNameReplacePattern();
  return this.dayMonthNameReplacePattern;
 },
 createDayMonthNameReplacePattern: function() {
  var parts = [ ] ;
  parts.push("(?:");
  parts.push(this.createReplacePattern(ASPx.CultureInfo.monthNames));
  parts.push(this.createReplacePattern(ASPx.CultureInfo.genMonthNames));
  parts.push(this.createReplacePattern(ASPx.CultureInfo.abbrMonthNames));
  parts.push(this.createReplacePattern(ASPx.CultureInfo.abbrDayNames));
  parts.push(this.createReplacePattern(ASPx.CultureInfo.dayNames));
  parts.push(")");
  return parts.join("");
 },
 createReplacePattern: function(names) {
  return names && names.length > 0 ? "\\b" + names.join("\\b|\\b") + "\\b" : "";
 },
 IsNumericSpecifier: function(sp) {
  var ch = sp.charAt(0);
  if(ch == "g" || ch == "t" || ((ch == "M" || ch == "d") && sp.length > 2))
   return false;
  return true;
 },
 IsKnownSpecifier: function(sp) {
  if(sp.length > 1)
   sp = sp.charAt(0);
  for(var i = 0; i < this.knownSpecifiers.length; i++) {
   if(this.knownSpecifiers[i] == sp)
    return true;
  }
  return false;
 }
});
DateFormatter.Create = function(format) {
 var instance = new DateFormatter();
 instance.SetFormatString(format);
 return instance;
};
DateFormatter.ExpandPredefinedFormat = function(format) {
 switch(format) {
  case "d":
   return ASPx.CultureInfo.shortDate;
  case "D":
   return ASPx.CultureInfo.longDate;
  case "t":
   return ASPx.CultureInfo.shortTime;
  case "T":
   return ASPx.CultureInfo.longTime;
  case "g":
   return ASPx.CultureInfo.shortDate + " " + ASPx.CultureInfo.shortTime;   
  case "f":
   return ASPx.CultureInfo.longDate + " " + ASPx.CultureInfo.shortTime;
  case "G":
   return ASPx.CultureInfo.shortDate + " " + ASPx.CultureInfo.longTime;
  case "F":
  case "U":
   return ASPx.CultureInfo.longDate + " " + ASPx.CultureInfo.longTime;   
  case "M":
  case "m":
   return ASPx.CultureInfo.monthDay;
  case "Y":
  case "y":
   return ASPx.CultureInfo.yearMonth;   
  case "O":
  case "o":
   return "yyyy'-'MM'-'dd'T'HH':'mm':'ss.fffffff";
  case "R":
  case "r":
   return "ddd, dd MMM yyyy HH':'mm':'ss 'GMT'";
  case "s":
   return "yyyy'-'MM'-'dd'T'HH':'mm':'ss";
  case "u":
    return "yyyy'-'MM'-'dd HH':'mm':'ss'Z'";
 }
 return format;
};
ASPx.DateFormatter = DateFormatter;
})();
