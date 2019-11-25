/* 
 Serial String Table Load to display previous data from .csv file, overlay
 of multiple runs, etc. for 12v batts disch
 */

// pared import list to just what's needed
import org.gwoptics.graphics.*;  // graphing libs only work in Proc 2
import org.gwoptics.graphics.graph2D.*;
import org.gwoptics.graphics.graph2D.Graph2D;
import org.gwoptics.graphics.graph2D.backgrounds.*;

GridBackground gb;

Graph2D grph;       // obj from above lib to make graph outline

Table volTab;     // or load an old one from disk to continue a plot
PFont f;            // to display text in window

void setup() 
{
  size(930, 540); // window size 90 px larger than graph

 // make the Graph2D object,
  // arguments are : parent object, xsize, ysize, cross axes at zero pt
  grph = new Graph2D(this, 840, 450, false);
  // set properties of the X , Y Axes
  grph.setYAxisMin(12.4f);
  grph.setYAxisMax(12.85f);  // 450 px ht = 450 mV
  grph.setXAxisMin(0);
  grph.setXAxisMax(280); // 840 px/3 = 280 min, 3 px/min
  grph.setXAxisLabel("minutes");
  grph.setYAxisLabel("voltage");
  grph.setXAxisLabelAccuracy(0);  // # of decimal places shown
  grph.setXAxisTickSpacing(30);  // major ticks
  grph.setYAxisTickSpacing(0.1);
  grph.setYAxisMinorTicks(4); // # of ticks between each major tick, 5 divisions


  // Offset of the top left corner of the plotting area
  // to the app window origin -- top left corner
  // (make x > 50 so you can see the y-axis label)
  grph.position.x = 60;
  grph.position.y = 20;
  // switching on Grid, with different colours for X and Y lines
  gb = new GridBackground(new GWColour(250)); //bkgnd for plot area
  gb.setGridColour(240, 180, 180, 240, 180, 180);
  grph.setBackground(gb);
  grph.setXAxisLabelFont("Arial", 16, false);
  grph.setYAxisLabelFont("Arial", 16, false);
  f = createFont("Arial", 14);
  textFont(f);  // will be used for applet window text
  //println(Serial.list()); // prints (available) serial ports to console

  // table holds values as strings, needs header but no blank rows!
 volTab = loadTable("data/2019delta1.csv", "header");
  background(255);
}  // end setup

void draw()   // redraw called by each incoming set of 3 vals
{   
  background(255);  // if here, clears all on each redraw
  grph.draw(); // the graph outline
  stroke(190); // very lt line for theoretic dc curve 12.5v @ 240"
  line(70, 70, 780, 370); // x= 60+min*3, y=20+(12850-mV)
  stroke(0);  // draw data darker
  ellipseMode(CENTER); // center on data pt
  
  //  access vals by iterating over rows in table where stored
for (int i = 0; i < volTab.getRowCount(); i++) // graph table vals
    {   // seems to start index and rowCnt @ vals not header
      TableRow row = volTab.getRow(i);
      // You can addr the fields by column name (or index)
      int m  = int(row.getString("min"));
      int v = int(row.getString("mV"));
      // int c = int(row.getString("mA")); // curr not graphed yet
      // plot all table vals to the graph
      fill(255, 100, 100);  // fill circle w/ red
      ellipse(60+m*3, 20+12850-v, 5, 5); // x=60+min*3, y=20+(12850-mV)
      // used to debug: show row #, data, tbl row count
      //     String what = "r "+ i + "  m " + m + "  rC " + volTab.getRowCount();
      //     fill(255);
      //     rect(195,30,200,30); // white out small area 
      //     fill(0);
      //     text(what,200,50);
    }  // end for loop over table vals


  // display result string at top of applet graph if anything to show:
//  if (resultString != null) 
//  {       
//    fill(0); // black txt
//    text(resultString, 200, 60);  // what,x,y
//  }
  noLoop(); // just draw vals once each time (redraw) called by Ser Event
}  // end draw



