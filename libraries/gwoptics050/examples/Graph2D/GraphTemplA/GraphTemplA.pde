/**
 * mod from gwoptics Scatter Plot Basic, to make v - time graph
 * 
 **/
 
import org.gwoptics.graphics.graph2D.Graph2D;

Graph2D grph;

void setup()
{
  size(840,640); // window size

  // Creating the Graph2D object:
  // arguments are the parent object, xsize, ysize, cross axes at zero pt
  grph = new Graph2D(this, 750, 550, false); 

  // Defining properties of the X and Y Axes
  grph.setYAxisMin(12.4f);
  grph.setYAxisMax(12.85f);
  grph.setXAxisMin(0);
  grph.setXAxisMax(300);
  grph.setXAxisLabel("minutes");
  grph.setYAxisLabel("voltage");
  grph.setXAxisLabelAccuracy(0);  // # of decimal places shown
  grph.setXAxisTickSpacing(30);
  grph.setYAxisTickSpacing(0.1);
  grph.setYAxisMinorTicks(4); // # between each major tick, 5 divis
  
  // Offset of the top left corner of the plotting area
  // to the sketch origin (should not be zero in order to
  // see the y-axis label
  grph.position.x = 80;
  grph.position.y = 60;
  
}  // end setup

void draw()
{
  background(255);
  grph.draw();
}  //  end draw
