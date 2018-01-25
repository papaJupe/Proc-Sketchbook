/*
MatchIntinStringA -- attempt to match multiple similar things in string
 -- match returns only first one; to find more than 1 I use matchAll --> 2D array
Uses: match, matchAll
*/

String sentence = "Bo is a perfect 10; and she's over 21! Addr:90211";

// should make array of matches, but only finds first match; (grouping) doesn't help
//String[] m = match(sentence, "B.*?\\b");  // just finds Bo (B/any3ofchar/word boundary)
//String[] m = match(sentence, "([0-9]+)"); // just finds 1st match 10,  \\d+ works same
//String[] m = match(sentence, "(B.*?\\b)|([0-9]+)");  //just finds Bo, second group null

// to find all matches I need:
//String[][] m = matchAll(sentence, "((\\d+)|(B.*?\\b))"); //-> 4 groups, confusing duplicate vals
//String[][] m = matchAll(sentence, "(\\d+)|(B.*?\\b)");//-> 4 groups, shorter, still dups
String[][] m = matchAll(sentence, "\\d+|B.*?\\b"); // no groups, just the 4 things
            // --> Bo & all 3 digit chunks in 2D array, just one thing each row
if (m != null) 
{
  println("total found: " + m.length);
  
  for (int i = 0; i < m.length; i++) 
  {
    // Print out groups for each match                
    // println("m[i]0 or 1 " + m[i][0]); // 0, 1 are same
    // for (int j = 0; j < m[i].length; j++)
    //{println("m[i][j] " + m[i][j]);} // end inner for
    
    println("m[" + i +"] " + m[i][0] ); // the one thing in each row
  } // end for
  // println(m); // elem 0 of each row has the full match, 1-> the group (same)
}      // 1 maybe null depending on group order in pattern
exit();   // quits app whether any found or not

