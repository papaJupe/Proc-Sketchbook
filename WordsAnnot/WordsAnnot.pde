/**
 * Words. 
 * 
 * The text() function is used for writing words to the screen.
 * The letters can be aligned left, center, or right with the 
 * textAlign() function. 
 */
  
PFont f;
  
void setup() {
  size(640, 360);
  
  // Create the font
  println(PFont.list()); // prints list of system fonts in console
  f = createFont("Georgia", 24);
  textFont(f);
}

void draw() 
{
  background(102);
  textAlign(RIGHT);
  drawType(width * 0.25); // gives function horiz loc to print at
  textAlign(CENTER);
  drawType(width * 0.5);
  textAlign(LEFT);
  drawType(width * 0.75);
}

void drawType(float x) // make lines and letters at given x loc
{
  line(x, 0, x, 65);  // upper line segment start/stop
  line(x, 220, x, height);  // lower segment
   fill(0);
  text("ichi", x, 95);
  fill(51);
  text("ni", x, 130);
  fill(204);
  text("san", x, 165);
  fill(255);
  text("shi", x, 210);
}
