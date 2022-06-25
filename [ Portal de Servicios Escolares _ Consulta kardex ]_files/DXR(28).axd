(function() {
ASPx.Formatter = {
 Format: function() {
  if(arguments.length < 1) 
   return "";
  var format = arguments[0];
  if(format == null)
   return "";
  var args;
  if(arguments.length > 1 && arguments[1] != null && arguments[1].constructor == Array) {
   args = arguments[1];
  } else {
   args = [ ];
   for(var i = 1; i < arguments.length; i++)
    args.push(arguments[i]);
  }
  var bag = [ ];
  var pos = 0;
  var savedPos = 0;  
  while(pos < format.length) {
   var ch = format.charAt(pos);
   pos++;
   if(ch == '{') {
    bag.push(format.substr(savedPos, pos - savedPos - 1));    
    if(format.charAt(pos) == "{") {
     savedPos = pos;
     pos++;
     continue;
    }
    var spec = this.ParseSpec(format, pos);
    var pos = spec.pos;
    var arg = args[spec.index];
    var argString;
    if(arg == null) {
     argString = "";
    } else if(typeof arg == "number") {
     argString = ASPx.NumberFormatter.Format(spec.format, arg);
    } else if(arg.constructor == Date) {     
     if(spec.format != this.activeDateFormat) {
      this.activeDateFormat = spec.format;
      if(spec.format == "")
       spec.format = "G";      
      if(spec.format.length == 1)
       spec.format = ASPx.DateFormatter.ExpandPredefinedFormat(spec.format);
      this.GetDateFormatter().SetFormatString(spec.format);
     }
     if(this.activeDateFormat == "U")
      arg = ASPx.DateUtils.ToUtcTime(arg);
     argString = this.GetDateFormatter().Format(arg);
    } else {
     argString = String(arg);     
     if(spec.format != "" && argString.length > 0) {
      var num = Number(argString.replace(",", "."));
      if(!isNaN(num))
       argString = ASPx.NumberFormatter.Format(spec.format, num);
     }
    }
    var padLen = spec.width - argString.length;
    if(padLen > 0) {
     if(spec.left)
      bag.push(argString);
     for(var i = 0; i < padLen; i++)
      bag.push(" ");
     if(!spec.left)
      bag.push(argString);
    } else {
     bag.push(argString);
    }
    savedPos = pos;
   }
   else if(ch == "}" && pos < format.length && format.charAt(pos) == "}") {
    bag.push(format.substr(savedPos, pos - savedPos - 1));
    savedPos = pos;
    pos++;
   }
   else if (ch == "}") {
    return "";
   }
  }
  if(savedPos < format.length)
   bag.push(format.substr(savedPos));   
  return bag.join("");
 },
 ParseSpec: function(format, pos) {
  var result = {
   index: -1,   
   left: false,
   width: 0,
   format: "",
   pos: 0
  };
  var savedPos, ch;
  savedPos = pos;
  while(true) {   
   ch = format.charAt(pos);
   if(ch < "0" || ch > "9")
    break;
   pos++;
  }  
  if(pos > savedPos)
   result.index = Number(format.substr(savedPos, pos - savedPos));  
  if(format.charAt(pos) == ",") {
   pos++;
   while(true) {
    ch = format.charAt(pos);
    if(ch != " " && ch != "\t")
     break;
    pos++;
   }
   result.left = format.charAt(pos) == "-";
   if(result.left)
    pos++;   
   savedPos = pos;
   while(true) {
    ch = format.charAt(pos);
    if(ch < "0" || ch > "9")
     break;
    pos++;
   }
   if(pos > savedPos)
    result.width = Number(format.substr(savedPos, pos - savedPos));
  }
  if(format.charAt(pos) == ":") {
   pos++;
   savedPos = pos;
   while(format.charAt(pos) != "}")
    pos++;
   result.format = format.substr(savedPos, pos - savedPos);
  }
  pos++;
  result.pos = pos;
  return result;
 },
 activeDateFormat: null,
 GetDateFormatter: function() {
  if(!this.__dateFormatter)
   this.__dateFormatter = new ASPx.DateFormatter();
  return this.__dateFormatter;
 }
};
ASPx.NumberFormatter = {
 Format: function(format, value) {
  if(isNaN(value))
   return ASPx.CultureInfo.numNan;
  if(!isFinite(value)) {
   return value > 0 
    ? ASPx.CultureInfo.numPosInf 
    : ASPx.CultureInfo.numNegInf;
  }
  this.FillFormatInfo(format);
  if(this.spec == "X")
   return this.FormatHex(value);
  this.FillDigitInfo(value);  
  switch(this.spec) {
   case "C":
    return this.FormatCurrency();
   case "D":
    return this.FormatDecimal();
   case "E":
    return this.FormatExp();
   case "F":
    return this.FormatFixed();
   case "G":   
    return this.FormatGeneral();
   case "N":
    return this.FormatNumber();
   case "P":
    return this.FormatPercent();
   default:
    if(this.custom)
     return this.FormatCustom(format);
    return "?";
  }
 },
 positive: true,
 digits: null,
 pointPos: 0, 
 spec: "",
 prec: -1,  
 upper: true,
 custom: false,
 FormatCurrency: function() {  
  if(this.prec < 0)
   this.prec = ASPx.CultureInfo.currPrec;
  this.Round(this.prec);
  var bag = [ ];
  if(this.positive) {
   switch(ASPx.CultureInfo.currPosPattern) {
    case 0:
     bag.push(ASPx.CultureInfo.currency);
     break;
    case 2:
     bag.push(ASPx.CultureInfo.currency, " ");     
     break;     
   }
  } else {
   switch(ASPx.CultureInfo.currNegPattern) {
    case 0:
     bag.push("(", ASPx.CultureInfo.currency);
     break;
    case 1:
     bag.push("-", ASPx.CultureInfo.currency);
     break;
    case 2:
     bag.push(ASPx.CultureInfo.currency, "-");
     break;
    case 3:
     bag.push(ASPx.CultureInfo.currency);
     break;
    case 4:
     bag.push("(");
     break;
    case 5:
    case 8:
     bag.push("-");
     break;
    case 9:
     bag.push("-", ASPx.CultureInfo.currency, " ");
     break;
    case 11:
     bag.push(ASPx.CultureInfo.currency, " ");
     break;
    case 12:
     bag.push(ASPx.CultureInfo.currency, " -");
     break;
    case 14:
     bag.push("(", ASPx.CultureInfo.currency, " ");
     break;
    case 15:
     bag.push("(");
     break;
   }
  }
  this.AppendGroupedInteger(bag, ASPx.CultureInfo.currGroups, ASPx.CultureInfo.currGroupSeparator);
  if(this.prec > 0) {
   bag.push(ASPx.CultureInfo.currDecimalPoint);
   this.AppendDigits(bag, this.pointPos, this.pointPos + this.prec);
  }
  if(this.positive) {
   switch(ASPx.CultureInfo.currPosPattern) {
    case 1:
     bag.push(ASPx.CultureInfo.currency);
     break;
    case 3:
     bag.push(" ", ASPx.CultureInfo.currency);
     break;     
   }   
  } else {
   switch(ASPx.CultureInfo.currNegPattern) {
    case 0:
    case 14:
     bag.push(")");
     break;
    case 3:
     bag.push("-");
     break;
    case 4:
     bag.push(ASPx.CultureInfo.currency, ")");
     break;
    case 5:
     bag.push(ASPx.CultureInfo.currency);
     break;
    case 6:
     bag.push("-", ASPx.CultureInfo.currency);
     break;
    case 7:
     bag.push(ASPx.CultureInfo.currency, "-");
     break;
    case 8:
     bag.push(" ", ASPx.CultureInfo.currency);
     break;
    case 10:
     bag.push(" ", ASPx.CultureInfo.currency, "-");
     break;
    case 11:
     bag.push("-");
     break;
    case 13:
     bag.push("- ", ASPx.CultureInfo.currency);
     break;
    case 15:
     bag.push(" ", ASPx.CultureInfo.currency, ")");
     break;
   }
  }
  return bag.join("");
 }, 
 FormatDecimal: function() {
  if(this.prec < this.pointPos)
   this.prec = this.pointPos;
  if(this.prec < 1)
   return "0";
  var bag = [ ];
  if(!this.positive)
   bag.push("-");
  this.AppendDigits(bag, this.pointPos - this.prec, this.pointPos);
  return bag.join("");
 },
 FormatExp: function() {  
  if(this.prec < 0)
   this.prec = 6;
  this.Round(1 - this.pointPos + this.prec);
  return this.FormatExpCore(3);
 },
 FormatExpCore: function(minExpDigits) {
  var bag = [ ];
  if(!this.positive)
   bag.push("-");
  this.AppendDigits(bag, 0, 1);
  if(this.prec > 0) {
   bag.push(ASPx.CultureInfo.numDecimalPoint);
   this.AppendDigits(bag, 1, 1 + this.prec);
  }
  bag.push(this.upper ? "E" : "e");
  var order = this.pointPos - 1;  
  if(order >= 0) {
   bag.push("+");
  } else {
   bag.push("-");
   order = -order;
  }
  var orderStr = String(order);
  for(var i = orderStr.length; i < minExpDigits; i++)
   bag.push(0);
  bag.push(orderStr);
  return bag.join("");
 },
 FormatFixed: function() {
  if(this.prec < 0)
   this.prec = ASPx.CultureInfo.numPrec;
  this.Round(this.prec);
  var bag = [ ];
  if(!this.positive)
   bag.push("-");
  if(this.pointPos < 1)
   bag.push(0);
  else
   this.AppendDigits(bag, 0, this.pointPos);
  if(this.prec > 0) {
   bag.push(ASPx.CultureInfo.numDecimalPoint);
   this.AppendDigits(bag, this.pointPos, this.pointPos + this.prec);
  }
  return bag.join(""); 
 },
 FormatGeneral: function() {
  var hasFrac = this.pointPos < this.digits.length;
  var allowExp;
  if(this.prec < 0) {
   allowExp = hasFrac;
   this.prec = hasFrac ? 15 : 10;
  } else {   
   allowExp = true;
   if(this.prec < 1)
    this.prec = hasFrac ? 15 : 10;
   this.Round(this.prec - this.pointPos);
  }
  if(allowExp) {
   if(this.pointPos > this.prec || this.pointPos <= -4) {
    this.prec = this.digits.length - 1;
    return this.FormatExpCore(2);
   }
  }
  this.prec = Math.min(this.prec, Math.max(1, this.digits.length)) - this.pointPos;
  return this.FormatFixed();
 },
 FormatNumber: function() {
  if(this.prec < 0)
   this.prec = ASPx.CultureInfo.numPrec;
  this.Round(this.prec);
  var bag = [ ];
  if(!this.positive) {
   switch(ASPx.CultureInfo.numNegPattern) {
    case 0:
     bag.push("(");
     break;
    case 1:
     bag.push("-");
     break;
    case 2:
     bag.push("- ");
     break;
   }
  }
  this.AppendGroupedInteger(bag, ASPx.CultureInfo.numGroups, ASPx.CultureInfo.numGroupSeparator);
  if(this.prec > 0) {
   bag.push(ASPx.CultureInfo.numDecimalPoint);
   this.AppendDigits(bag, this.pointPos, this.pointPos + this.prec);
  }
  if(!this.positive) {
   switch(ASPx.CultureInfo.numNegPattern) {
    case 0:
     bag.push(")");
     break;
    case 3:
     bag.push("-");
     break;
    case 4:
     bag.push(" -");
     break;
   }
  }
  return bag.join("");
 },
 FormatPercent: function() {
  if(this.prec < 0)
   this.prec = ASPx.CultureInfo.numPrec;
  if(this.digits.length > 0)
   this.pointPos += 2;
  this.Round(this.prec);
  var bag = [ ];
  if(!this.positive)
   bag.push("-");
  if(ASPx.CultureInfo.percentPattern == 2)
   bag.push("%");    
  this.AppendGroupedInteger(bag, ASPx.CultureInfo.numGroups, ASPx.CultureInfo.numGroupSeparator);
  if(this.prec > 0) {
   bag.push(ASPx.CultureInfo.numDecimalPoint);
   this.AppendDigits(bag, this.pointPos, this.pointPos + this.prec);
  }  
  switch(ASPx.CultureInfo.percentPattern) {
   case 0:
    bag.push(" %");
    break;
   case 1:
    bag.push("%");
    break;
  }  
  return bag.join("");
 },
 FormatHex: function(value) {
  var result = value.toString(16);
  if(result.indexOf("(") > -1)
   return result;
  result = this.upper ? result.toUpperCase() : result.toLowerCase();
  if(this.prec <= result.length)
   return result;
  var bag = [ ];
  for(var i = result.length; i < this.prec; i++)
   bag.push(0);
  bag.push(result);
  return bag.join("");
 },
 FormatCustom: function(format) {
  var sectionList = this.GetCustomFormatSections(format);
  var section = this.SelectCustomFormatSection(sectionList);
  if(section == "")
   return this.positive ? "" : "-";
  var info = this.ParseCustomFormatSection(section);
  var lists = this.CreateCustomFormatLists(info);
  if(sectionList.length > 2 && section != sectionList[2]) {
   var zero = lists.i.concat(lists.f).join("").split(0).join("") == "";
   if(zero) {
    section = sectionList[2];
    info = this.ParseCustomFormatSection(section);
    lists = this.CreateCustomFormatLists(info);   
   }   
  }
  return this.FormatCustomCore(section, info, lists);
 },
 GetCustomFormatSections: function(format) {
  var sections = [ ];
  var escaping = false;
  var quote = "";
  var length = 0;
  var prevPos = 0;
  for(var i = 0; i < format.length; i++) {
   var ch = format.charAt(i);
   if(!escaping && quote == "" && ch == ";") {
    sections.push(format.substr(prevPos, length));
    length = 0;
    prevPos = i + 1;
    if(sections.length > 2)
     break;
   } else {
    if(escaping)
     escaping = false;
    else if(ch == quote)
     quote = quote == "" ? ch : "";
    else if(ch == "\\")
     escaping = true;
    else if(ch == "'" || ch == '"')
     quote = ch;
    ++length;
   }
  }
  if(length > 0)
   sections.push(format.substr(prevPos, length));
  if(sections.length < 1)
   sections.push(format);
  return sections;
 },
 SelectCustomFormatSection: function(sections) {
  if(!this.positive && sections.length > 1 && sections[1] != "") {
   this.positive = true;
   return sections[1];
  }
  if(this.digits.length < 1 && sections.length > 2 && sections[2] != "")
   return sections[2];
  return sections[0];
 },
 CreateCustomFormatInfo: function() {
  return {
   pointPos: -1,
   grouping: false,
   exp: false,
   expShowPlus: false,
   percent: false,
   scaling: 0,
   intDigits: 0,
   fracDigits: 0,
   expDigits: 0,
   intSharps: 0,
   fracSharps: 0, 
   expSharps: 0
  };
 },
 ParseCustomFormatSection: function(section) {  
  var quote = "";
  var area = "i"; 
  var canParseIntSharps = true;
  var result = this.CreateCustomFormatInfo();
  var groupSeparators = 0;  
  for(var i = 0; i < section.length; i++) {
   var ch = section.charAt(i);   
   if(ch == quote) {
    quote = "";    
    continue;
   }
   if(quote != "")
    continue;
   if(area == "e" && ch != "0" && ch != "#") {
    area = result.pointPos < 0 ? "i" : "f";
    i--;
    continue;
   }
   switch(ch) {
    case "\\":
     i++;
     continue;
    case "'":
    case '"':
     quote = ch;
     continue;
    case "#":
    case "0":
     if(ch == "#") {
      switch(area) {
       case "i":
        if(canParseIntSharps)
         result.intSharps++;
        break;
       case "f":
        result.fracSharps++;
        break;
       case "e":
        result.expSharps++;
        break;
      }
     } else {
      canParseIntSharps = false;
      switch(area) {
       case "f":
        result.fracSharps = 0;        
        break;
       case "e":
        result.expSharps = 0;
        break;
      }
     }
     switch(area) {
      case "i":
       result.intDigits++;
       if(groupSeparators > 0)
        result.grouping = true;
       groupSeparators = 0;
       break;
      case "f":
       result.fracDigits++;  
       break;
      case "e":
       result.expDigits++;
       break;
     }
     break;
    case "e":
    case "E":
     if(result.exp)
      break;
     result.exp = true;     
     area = "e"; 
     if(i < section.length - 1) {
      var next = section.charAt(1 + i);
      if(next == "+" || next == "-") {
       if(next == "+")
        result.expShowPlus = true;
       i++;
      }
      else if(next != "0" && next != "#") {
       result.exp = false;
       if(result.pointPos < 0)
        area = "i";       
      }
     }
     break;
    case ".":
     area = "f";
     if(result.pointPos < 0)
      result.pointPos = i;
     break;
    case "%":
     result.percent = true;     
     break;
    case ",":
     if(area == "i" && result.intDigits > 0)
      groupSeparators++;
     break;
    default:
     break;
   }
  }
  if(result.expDigits < 1)
   result.exp = false;
  else
   result.intSharps = 0;
  if(result.fracDigits < 1)
   result.pointPos = -1;
  result.scaling = 3 * groupSeparators;  
  return result;
 },
 CreateCustomFormatLists: function(info) {
  var intList = [ ];
  var fracList = [ ];
  var expList = [ ];
  if(this.digits.length > 0) {
   if(info.percent)
    this.pointPos += 2;
   this.pointPos -= info.scaling;
  }
  var expPositive = true;
  if(info.exp && (info.intDigits > 0 || info.fracDigits > 0)) {
   var diff = 0;
   if(this.digits.length > 0) {
    this.Round(info.intDigits + info.fracDigits - this.pointPos);
    diff -= this.pointPos - info.intDigits;
    this.pointPos = info.intDigits;
   }
   expPositive = diff <= 0;   
   expList = String(diff < 0 ? -diff : diff).split("");
  } else {
   this.Round(info.fracDigits);
  }
  if(this.digits.length < 1 || this.pointPos < 1)
   intList = [ 0 ];
  else
   this.AppendDigits(intList, 0, this.pointPos);
  this.AppendDigits(fracList, this.pointPos, this.digits.length);
  if(info.exp) {
   while(intList.length < info.intDigits)
    intList.unshift(0);
   while(expList.length < info.expDigits - info.expSharps)
    expList.unshift(0);
   if(expPositive && info.expShowPlus)
    expList.unshift("+");
   else if(!expPositive)
    expList.unshift("-");
  } else {
   while(intList.length < info.intDigits - info.intSharps)
    intList.unshift(0);    
   if(info.intSharps >= info.intDigits) {
    var zero = true;
    for(var i = 0; i < intList.length; i++) {
     if(intList[i] != 0) {
      zero = false;
      break;
     }
    }
    if(zero)
     intList = [ ];
   }
  }
  while(fracList.length < info.fracDigits - info.fracSharps)
   fracList.push(0);
  return {
   i: intList,
   f: fracList,
   e: expList
  };
 },
 FormatCustomCore: function(section, info, lists) {
  var intLen = 0; 
  var total = 0;
  var groupIndex = 0; 
  var counter = 0;
  var groupSize = 0;
  if(info.grouping && ASPx.CultureInfo.numGroups.length > 0) {
   intLen = lists.i.length;
   for(var i = 0; i < ASPx.CultureInfo.numGroups.length; i++) {
    if(total + ASPx.CultureInfo.numGroups[i] <= intLen) {
     total += ASPx.CultureInfo.numGroups[i];
     groupIndex = i;
    }
   }
   groupSize = ASPx.CultureInfo.numGroups[groupIndex];
   var fraction = intLen > total ? intLen - total : 0;
   if(groupSize == 0) {
    while(groupIndex >= 0 && ASPx.CultureInfo.numGroups[groupIndex] == 0)
     groupIndex--;
    groupSize = fraction > 0 ? fraction : ASPx.CultureInfo.numGroups[groupIndex];
   }
   if(fraction == 0) {
    counter = groupSize;
   } else {
    groupIndex += Math.floor(fraction / groupSize);
    counter = fraction % groupSize;
    if(counter == 0)
     counter = groupSize;
    else
     groupIndex++;
   }
  } else {
   info.grouping = false;
  }
  var bag = [ ];
  var area = "i";
  var intSharps = 0;
  var intListIndex = 0;
  var fracListIndex = 0;
  var savedCh = "";
  for(var i = 0; i < section.length; i++) {
   var ch = section.charAt(i);
   if(ch == savedCh) {
    savedCh = "";
    continue;
   }
   if(savedCh != "") {
    bag.push(ch);
    continue;
   }
   switch(ch) {
    case "\\":
     ++i;
     if(i < section.length)
      bag.push(section.charAt(i));
     continue;
    case "'":
    case '"':     
     savedCh = ch;
     continue;
    case "#":     
    case "0":
     if(area == "i") {
      intSharps++;
      if(ch == "0" || info.intDigits - intSharps < lists.i.length + intListIndex) {
       while(info.intDigits - intSharps + intListIndex < lists.i.length) {
        bag.push(lists.i[intListIndex]);
        intListIndex++;
        if(info.grouping && --intLen > 0 && --counter == 0) {
         bag.push(ASPx.CultureInfo.numGroupSeparator);
         if(--groupIndex < ASPx.CultureInfo.numGroups.length && groupIndex >= 0)
          groupSize = ASPx.CultureInfo.numGroups[groupIndex];
         counter = groupSize;
        }
       }
      }
     } else if(area == "f") {
      if(fracListIndex < lists.f.length) {
       bag.push(lists.f[fracListIndex]);
       fracListIndex++;
      }
     }
     break;
    case "e":
    case "E":
     if(lists.e == null || !info.exp) {
      bag.push(ch);
      break;
     }
     for(var q = i + 1; q < section.length; q++) {
      if(q == i + 1 && (section.charAt(q) == "+" || section.charAt(q) == "-"))
       continue;                   
      if(section.charAt(q) == "0" || section.charAt(q) == "#")
       continue;
      break;
     }
     i = q - 1;
     area = info.pointPos < 0 ? "i" : "f";
     bag.push(ch);
     bag = bag.concat(lists.e);
     lists.e = null;      
     break;
    case ".":
     if(info.pointPos == i && lists.f.length > 0)
      bag.push(ASPx.CultureInfo.numDecimalPoint);
     area = "f";
     break;
    case ",":
     break;
    default:
     bag.push(ch);
     break;
   }
  }
  if(!this.positive)
   bag.unshift("-");
  return bag.join("");
 },
 FillDigitInfo: function(value) {
  this.positive = true;
  if(value < 0) {
   value = -value;
   this.positive = false;   
  }
  this.digits = [ ];
  this.pointPos = 0;    
  if(value == 0 || !isFinite(value) || isNaN(value)) {
   this.pointPos = 1;
   return;
  }
  var list = String(value).split("e");
  var str = list[0];
  if(list.length > 1) {   
   this.pointPos = Number(list[1]);
  }
  var frac = false;
  var decimalCount = 0;
  for(var i = 0; i < str.length; i++) {
   var ch = str.charAt(i);
   if(ch == ".") {
    frac = true;
   } else {
    if(frac)
     decimalCount++;     
    if(ch != "0" || this.digits.length > 0)
     this.digits.push(Number(ch));
   }
  }
  this.pointPos += this.digits.length - decimalCount;
 },
 FillFormatInfo: function(format) {
  this.upper = true;
  this.custom = false;
  this.prec = -1;
  var spec;
  if(format == null || format.length < 1)
   spec = "G";
  else
   spec = format.charAt(0);
  if(spec >= "a" && spec <= "z") {
   spec = spec.toUpperCase();
   this.upper = false;
  }
  if(spec >= "A" && spec <= "Z") {   
   if(format != null && format.length > 1) {
    var prec = Number(format.substr(1));
    if(!isNaN(prec))
     this.prec = prec;
    else
     this.custom = true;
   }
  } else {
   this.custom = true;   
  }  
  this.spec = this.custom ? "0" : spec;
 },
 Round: function(shift) {
  var amount = this.digits.length - this.pointPos - shift;
  if(amount <= 0) 
   return;
  var cutPos = this.pointPos + shift;
  if(cutPos < 0) {
   this.digits = [ ];
   this.pointPos = 0;
   return;
  }
  var digit = this.digits[cutPos];
  if(digit > 4) { 
   for(var i = 0; i < amount; i++) {
    var index = cutPos - 1 - i;
    if(index < 0) {
     this.digits.unshift(0);
     this.pointPos++;
     cutPos++;
     index++;
    }
    digit = this.digits[index];    
    if(digit < 9) {
     this.digits[index] = 1 + digit;
     break;
    } else {
     this.digits[index] = 0;
     amount++;
    }
   }
  }
  for(var i = cutPos - 1; i >= 0; i--) {
   if(this.digits[i] > 0) break;
   cutPos--;
  }
  this.digits.splice(cutPos, this.digits.length - cutPos);
 },
 AppendGroupedInteger: function(list, groups, separator) { 
  if(this.pointPos < 1) {
   list.push(0);
   return;
  }
  var total = 0;
  var groupIndex = 0;
  for(var i = 0; i < groups.length; i++) {
   if(total + groups[i] <= this.pointPos) {
    total += groups[i];
    groupIndex = i;
   }
   else
    break;
  }
  if(groups.length > 0 && total > 0) {
   var counter;
   var groupSize = groups[groupIndex];
   var fraction = this.pointPos > total ? this.pointPos - total : 0;
   if(groupSize == 0) {
    while(groupIndex >= 0 && groups[groupIndex] == 0)
     groupIndex--;
    groupSize = fraction > 0 ? fraction : groups[groupIndex];
   }
   if(fraction == 0) {
    counter = groupSize;
   } else {
    groupIndex += Math.floor(fraction / groupSize);
    counter = fraction % groupSize;
    if(counter == 0)
     counter = groupSize;
    else
     groupIndex++;
   }
   var i = 0;
   while(true) {
    if(this.pointPos - i <= counter || counter == 0) {
     this.AppendDigits(list, i, this.pointPos);
     break;
    }
    this.AppendDigits(list, i, i + counter);
    list.push(separator);
    i += counter;    
    groupIndex--;     
    if(groupIndex < groups.length && groupIndex >= 0)
     groupSize = groups[groupIndex];
    counter = groupSize;
   }
  } else {
   this.AppendDigits(list, 0, this.pointPos);   
  }  
 },
 AppendDigits: function(list, start, end) {
  for(var i = start; i < end; i++) {
   if(i < 0 || i >= this.digits.length)
    list.push(0);
   else
    list.push(this.digits[i]);
  }
 }
};
})();
