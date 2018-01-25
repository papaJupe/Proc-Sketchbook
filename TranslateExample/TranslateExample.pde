/**
 * TranslateExample mod from Proc Examples/Basics/transform/translate 
 * 
 * translate(hor,vert) resets coord frame (0,0) to
 * the x,y params.
 * The translate() function allows objects to be moved
 * to any location within the window. The first parameter
 * sets the x-axis offset and the second parameter sets the
 * y-axis offset from the native (0,0) -- reset each loop?
 */
 
float i, j; // no real need for float if all values ints
float dim = 80.0;  // square, 80 px each side

void setup() 
{
  size(360, 360);  // width, height
  noStroke();
  frameRate(20);
}

void draw() 
{
  background(102);  // clears bkgd each loop
  
  i = i + 1;  // gains a little each loop, shifting coord. frame R more and more
 
  if (i > width) // L edge of rect (0,0 of shifted cooord) hits R screen edge
    {
      i = 0;  // was -dim, L edge reset back from L screen edge by dim pixels, so R side is
      // at screen edge; now I start both sq at left edge 0 and transl there too
    } 
  
  translate(i, height/2); // as x value i is updated, ref frame (0,0) shifts right
                  // y value, rect bottom is centered on screen, stays put; i.e.
                  // y (0) reference stays at center line
  fill(255);  // white
  rect(0, -dim, dim, dim); // start dim px L (x) and above (y) center of L edge
  
     // Transforms accumulate (within loop?), so this shifts frame again Rtward
      // Notice how this sq moves twice as fast as the first, it uses the same 
      // parameter for the x-axis shift, adding to 1st shift, so rate *= 2
  translate(i, 0);  // keep y same as above, no added shift
  fill(0); // black
  rect(0, 0, dim, dim); // both squares restart at L edge when x param (i) resets to 0;
        // y corner starts at middle of screen (ht/2)
}
