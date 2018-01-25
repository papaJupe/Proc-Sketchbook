/* Load text file as String[] - each line of file makes 1 array element
 then split and cast tokens to int array for each line; then display vals
 in bar-graph
 Uses: loadStrings, split line to make # array
 */


int[] data;
int[] data2;

void setup() 
  { 
  size(200, 200);
   // Load text file as String[] - each line of file makes 1 element
  String[] stuff = loadStrings("data/datum.txt"); 
  data = int(split(stuff[0], ',')); //  split line into array of ints
  data2= int(split(stuff[1],',')); // second line split into ints
  } // end setup


void draw() 
{ 
  background(255); 
  stroke(0); 
  for (int i = 0; i < data.length; i++) 
    { // color proportional to value of col.
    fill(data[i]); // smaller # = darker
    rect(i*20, 0, 20, data[i]); // bar ht from top = val
    fill(data2[i]);
    rect(i*20, height-data2[i], 20, data2[i]); // bar ht from bottom
    } 
  noLoop();  // stops after one loop, works same here or last line of setup()
}  // enDraw
