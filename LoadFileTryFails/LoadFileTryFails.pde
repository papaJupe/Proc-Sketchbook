/* failed mod of LoadFile2Vals, try/catch -> exit, doesn't, many problems
 Load text file as String[] -> each line of file makes 1 array element
 then split at commas --> array of ints; display values as tinted bar heights
 Uses: loadStrings, split, draw bar graph from vals, noLoop, exit
 */

int[] data;   // 2 int arrays that hold parsed imported data
int[] data2;

void setup() 
{ 
  size(200, 200);
  String[] stuff = {"1", "2"}; // array to hold unparsed input
  // Load text file as String[] - each line of file makes 1 element
  // String[] stuff = loadStrings("datum.txt");  //txt or csv OK
  
  try {  // vars in try block must be first declared above
    stuff = loadStrings("dato.csv"); // no 'header' option here
  } 
  catch (Exception e)
  {  // code in catch doesn't execute, doesn't stop anything
    println("file open failed");
    System.exit(1);  // fails to exit, setup-draw goes ahead, unlike J's System.exit()
  } // end catch
  if (stuff != null)
  {
    data = int(split(stuff[0], ',')); // that we then split into array of ints
    data2= int(split(stuff[1], ',')); // second line split into ints
  }
} // end setup


void draw() 
{ 
  background(255); 
  stroke(0); 
  for (int i = 0; i < data.length; i++) 
  {      // color proportional to value of col data
    fill(data[i]); 
    rect(i*20, 0, 20, data[i]);// bars extend from top, ht proportional to value
    fill(data2[i]);
    rect(i*20, height-data2[i], 20, data2[i]); // bars extend from bottom edge
  } 
  noLoop();  // stops after one loop, works same here or last line of setup()
}  // enDraw

