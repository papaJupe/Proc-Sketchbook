/** GraphTemplB --
 * mod from gwoptics Scatter Plot Basic, to make v - time graph, mod B 
   adds data point over graph base or redraws it, when keyPressed
 * 
 **/
 
import org.gwoptics.graphics.graph2D.Graph2D;

Graph2D grph;
int counter = 1; // how many times n key pressed

void setup()
{
  size(930,530); // window size 90 px larger than graph

  // Creating the Graph2D object:
  // arguments are the parent object, xsize, ysize, cross axes at zero pt
  grph = new Graph2D(this, 840, 450, false); 

  // Defining properties of the X and Y Axes
  grph.setYAxisMin(12.4f);
  grph.setYAxisMax(12.85f);  // 450 px ht = 450 mV
  grph.setXAxisMin(0);
  grph.setXAxisMax(280); // 840 px/3 = 280 min, 3 px/min
  grph.setXAxisLabel("minutes");
  grph.setYAxisLabel("voltage");
  grph.setXAxisLabelAccuracy(0);  // # of decimal places shown
  grph.setXAxisTickSpacing(30);
  grph.setYAxisTickSpacing(0.1);
  grph.setYAxisMinorTicks(4); // # between each major tick, 5 divisions
  
  // Offset of the top left corner of the plotting area
  // to the app window origin -- top left corner
  // (> 50 so you can see the y-axis label)
  grph.position.x = 60;
  grph.position.y = 20;
  background(255);
  //frameRate(5); // slowing pointless if you use noLoop in draw
}  // end setup

void draw()
{
grph.draw();
stroke(190); // very lt line for theoretic dc curve 12.5v @ 240"
line(70,70,780,370); // x= 60+min*3, y = 20+(12850-mV)
noLoop(); // just draw once
}  //  end draw

void keyPressed() // must have its own thread built in (event loop?)
{  
if (key == 'n') 
  {
 // draw new point each time it's pressed
 stroke(0);  // draw data darker
 ellipseMode(CENTER); // center on data pt
 ellipse(counter*60+60,counter*40+50,7,7);
 redraw();  // run draw loop once to make graph base, works here or above
 counter++;
  } // end if
if (key == 'z')  // clear graph when it's pressed
  {
 background(255);
 counter = 1;
 redraw();
  } // end if
} // end  kP


//if (key == '\n') 
//  {
//  saved = typing; 
//  typing = "";   // clear typed string
//  } 

