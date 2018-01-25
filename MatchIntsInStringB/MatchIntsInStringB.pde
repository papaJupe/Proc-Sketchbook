/* 
  Match Ints in String B -- take messy string and extract the integers
  version A (v.s.) did it with matchAll's 2D array; version B is still more complicated
  than it should be, but works; try to add float extraction?
  Uses: splitTokens,StringList,match,conv. to array,parseInt,replaceAll
*/

String str = "Bo is a perfect 10; and she's over 21! Addr:90210";
  //String[] m = match(sentence, "[0-9]+");  //or \\d+ to get chunks of digits
  // should make array of matches, but only finds first match;(grouping) doesn't help
  // so this puts bits of it into str[]
String[] unfilt = splitTokens(str,": ");  // spaces are default, add more delim as 2nd param
println("unfilt= "); println(unfilt);
  // then pick the elements with numerals, put into StringList (easy to make & add to)
  
  // or, could have applied match or replaceAll to each string element 1st
StringList filt = new StringList();  // will hold substrings with dirty #s
for (String s : unfilt)
{   // if there's a digit in s substring, put the substr into filt StrList
  if (match(s, "[0-9]") != null) 
    filt.append(s);
}    // can you loop thru a StringList by element?  Yes, using x.get()
println("filt is"); println(filt);
   // convert to a str array to process pieces
String[] filtArr = filt.array(); // maybe could go from StrLst to num[] directly?
// sanitize each element, put into nums int[]
int[] nums = new int[filtArr.length];   // same size as str array
for (int n = 0; n < nums.length; n++)
  { 
    filtArr[n] = filtArr[n].replaceAll( "[^\\d]", ""); // purge non-digits
    nums[n] = Integer.parseInt(filtArr[n]); // fails unless sanitized
  }
println(nums);
exit();  // quits whether anything found or not
