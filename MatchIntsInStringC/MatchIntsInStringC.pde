/* Match Ints in String C -- using Pattern/Matcher J util w/ regex
   still way more complex than matchAll
   TODO try to add float extraction ?
   Uses: splitTokens,replaceAll,Pattern.compile,.matcher,.find,append,.group
*/

import java.util.regex.*;

String boString = "Bo is a PERFECT 10 ; and she's over 21! Addr:90210";
      //  splitTokens puts bits of it into str[]
      // spaces are default delim, can add others w/ 2nd param ".,: "
String[] boArray = splitTokens(boString);  
println("boArr = "); 
println(boArray);  // array with elements = words / tokens

// to sanitize each element of array, before I learned to use .find and .group()
// to pick out number clumps
//for (int n = 0; n < boArray.length; n++)
//    { 
//      boArray[n] = boArray[n].replaceAll( "[\\D]", ""); // purge non-digits
//    }        // \\D same as ^\\d
//print("sanitized array = \n"); println(boArray);

Pattern patt = Pattern.compile("[0-9]+"); // any digit clump

  // put just digit clumps in new stringList (as strings)
StringList justNums = new StringList();
for (String num : boArray)  
{
  Matcher m = patt.matcher(num);  // test each element of boArray
  if (m.find())   // .find just the digits; m.matches = true
              // if just digits -- fails if contaminated
    {
      //justNums.append(num); // this appends dirty substring
      justNums.append(m.group()); // append just the found numerals
      println(m.group());  // or m.group(0) -- clean numeral groups
      //println(num);  / the dirty substring
    }
  else println("No match");
}
println(justNums); //-->StrLst, size, [elements] on one line
     // could parse to build an Int[]
int[] numArr = new int[justNums.size()];  // StrList.size = # of elements
for (int n = 0; n < justNums.size(); n++)
   numArr[n] = int(justNums.get(n)); // could do Integer.parseInt(justNums.. but why?
println(numArr); // prints [index] val, one line each
exit();  // quits app, like cmd-Q or STOP

//String[] tests = { "HIGH","high","LOW","LOWER","Abc","DUFF","KILOWATT"};
// Pattern p = Pattern.compile("([A-Z]+)"); // str matches if ALL CAPS
// orig regex was "(?!LOW)([A-Z]{3,}+)"), reject any LOW__, req 3 caps or more

