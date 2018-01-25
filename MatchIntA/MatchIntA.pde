String sentence = "Bo is a perfect 10; and she's over 21! Addr:90210";

// should make array of matches, but only finds first match; (grouping) doesn't help
//String[] m = match(sentence, "B.*?\\b");  // just finds Bo
//String[] m = match(sentence, "([0-9]+)"); // just finds 10  \\d+ works same
//String[] m = match(sentence, "(B.*?\\b)|([0-9]+)");  //just finds Bo, second group null

// to find all matches seem to need
String[][] m = matchAll(sentence, "((\\d+)|(B.*?\\b))"); // gets Bo & all digit chunks in 2D array
       // adding outer (..) makes grp 1 more consistent
if (m != null) 
{
  //println("1st found: " + m[0]);  // fails if empty elem, so not good
  //println("2nd found: " + m[1]);
  println("total found: " + m.length);
  for (int i = 0; i < m.length; i++) 
  {
    // Print out group 1 for each match                
    println("m[i]1 " + m[i][1]);
  }
  //println(m); // elem 0 of each row has the full match, 1-> the group (same)
}      // 1 maybe null depending on group order in pattern
exit();   // quits app whether any found or not

