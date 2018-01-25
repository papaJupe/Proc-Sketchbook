/*
 ArraySyntaxByte mod from Example 10-07 from "Getting Started with Processing" 
 by Reas & Fry, O'Reilly, Make 2010
 in Proc byte goes -128 to 127, so automatically wraps around @ midscreen

 byte[] xVal = {-20,0,20}; // this works to declare array & assign values
         @ -20 top one starts off screen
  Uses: byte array, to draw some arcs to window
*/
byte[] xVal = new byte[3];  // this works too
// xVal[0] = -20;  // can't assign value here; OK in setup

void setup() 
{
  size(240, 240);
  smooth();
  noStroke();
  xVal[0] = -20;   // value assignment here OK
  xVal[1] = 10;  
  xVal[2] = 30;
  //  xVal[3] = 20;  // can't add element to array, get out of bounds exceptn
  frameRate(20);
}

void draw() 
{
  background(0);  // clears each loop
  fill(#ffffff); // white
  text("bytes cycle around at 128",10,10); // text baseln 10 px in from corner
  xVal[0] += 1;  // Increase the first element
  xVal[1] += 1;  // Increase the second element
  xVal[2] += 1;  // Increase the second element
  arc(xVal[0], 40, 40, 40, 0.52, 5.76);
  arc(xVal[1], 100, 40, 40, 0.52, 5.76);
  arc(xVal[2], 160, 40, 40, 0.62, 4.68);
}

