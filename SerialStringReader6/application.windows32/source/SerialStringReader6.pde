/* 
 Serial String Reader 6 -- for Win32 export, use Serial.list[1], or portName="COM_" prn ?
 C:\\path for data save. With energia on PC this still works, COM11 is 2nd on list, i.e. [1]
 Pairs with Ardu's SensorReader4, voltSamp6, energia voltSamp, sending 3 int csv data strings 
 autonomously, or when it gets a char sent from Proc. KeyPressed code, if handshaking 
 
 Reads a string of characters from the serial port until it gets a linefeed (ASCII 10).
 Then splits the string into tokens separated by commas, puts into str array and prints
 them to console and app window. Makes a Table to hold the values, saves it on key 's';
 serialEvent meth graphs the values to the window as they arrive. this (v.6) reads 
 stored vals in draw loop from Table when any new set arrives, adds backgnd gridlines,
 rearranges value display at top of chart
 
 Uses: Serial,bufferUntil,readString,split,trim,Table & methods,gwoptic lib-Graph2D,
 setYAxisLabelFont,GridBackground,serial write of key
 */

// pared import list to just what's needed
import processing.serial.*;  // import the Proc serial library
import org.gwoptics.graphics.*;  // graphing libs only work in Proc 2
import org.gwoptics.graphics.graph2D.*;
import org.gwoptics.graphics.graph2D.Graph2D;
import org.gwoptics.graphics.graph2D.backgrounds.*;

GridBackground gb;

Graph2D grph;       // obj from above lib to make graph outline
// int counter = 1; // how many times n (new pt) key pressed

Serial myPort;          // the serial port
String resultString;  // string holds the input data for printing
VolTable volTab;    // table to store incoming vals for file and graph
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
  // (make > 50 so you can see the y-axis label)
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
  println(Serial.list());   // prints (available) serial ports to console

  // get the # of your port from the serial.list
  // The first port in the serial list on my computer (mac) 
  // is generally the Arduino module, so I open Serial.list()[0].
  // Use correct # for your machine, [1] on Win32 usually works

  String portName = Serial.list()[1];  // usually 0 for MacPro, 1 for PC & iMac
  // open the serial port:
  myPort = new Serial(this, portName, 9600); // speed must match Ardu/MSP's
  // applet can only seize port if not in use: +/- close Ardu/Energia IDE or set it
  // to use different port than the board is using; may not need to do this
  // when you Quit Proc. applet releases port, so Ardu can reconnect

  // set Serial to read bytes into a buffer until a linefeed (ASCII 10):
  myPort.bufferUntil('\n');  // possibly MSP sends corrupt 1st few strings
  // table holds incoming values as strings
  volTab = new VolTable();
  background(255);
}  // end setup

void draw()   // redraw called by each incoming set of 3 vals
{   
  background(255);  // if here, clears all on each redraw
  grph.draw(); // the graph outline
  stroke(190); // very lt line for theoretic dc curve 12.5v @ 240"
  line(70, 70, 780, 370); // x= 60+min*3, y=20+(12850-mV)
  stroke(0);  // data pts will be filled circles
  ellipseMode(CENTER); // center on data pt
  // get vals by iterating over rows in table where they are stored
  if ( volTab.getRowCount() > 1)   // may not need this condx, doesn't show 1st line
  {
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
  }

    // display result string at top of applet graph if anything to show:
  if (resultString != null) 
  { //     noStroke(); 
    //     fill(255);
    //     rect(195,30,200,30); // white out small area      
    fill(0); // black txt
    text("min : mV : mA", 200, 50);
    text(resultString, 200, 70);  // what,x,y -- data or txt msg
  }
  noLoop(); // just graph vals once each time called on redraw
}  // end draw


// serialEvent method is run automatically by the Processing sketch
// whenever the buffer reaches the byte value \n set in the bufferUntil() 
// method in setup(): (presumably runs its own thread)

void serialEvent(Serial myPort) // watch myPort for events
{ 
  // read the serial buffer  -- must get exactly 3 numbers for table build to work
  String inputString = myPort.readString(); // was readStringUntil('\n') which
  // -- was supposed to exclude final \n, but no difference here +/- trim

  // trim [space, ret, \n, tab] from string ends only (Java meth should be same as):
  inputString = inputString.trim(); // was = trim(inputString) -- failed w/ flt??

  // split the input string at the commas
  // and put the tokens into sensors[] array [int,flt,str]: all types work, but
  String sensors[] = split(inputString, ',');    // str best for getting floats
  if (sensors.length != 3) 
    {
       resultString = inputString;  // to show incoming text msg
       redraw();
       return;  // imperfect input should be ignored
    }
  // assuming 3 ints recvd, reset resultString, values print to graph
  resultString = "";
  // add the values to the resultString: if no commas, whole string?
  for (int sensorNum = 0; sensorNum < sensors.length; sensorNum++) 
    {
      resultString += sensors[sensorNum] + "  ";
    }  // end for
  
  resultString = trim(resultString); // remove final spaces or tab
  
  println(resultString); // to console, also draw loop prints updated table
  // println(inputString);  //unparsed, untrimmed

  // add new vals to the table, may want some timer or counter control if coming fast
  // makes new row entry and fills key:val slots (col slot, value to put there)
  if (sensors.length == 3) // no new row made if not a full array, or get OOB except
  {
    TableRow newRow = volTab.addRow();
    newRow.setString("min", sensors[0]);  // (col's are index/key,value)
    newRow.setString("mV", sensors[1]);
    newRow.setString("mA", sensors[2]);
    
    redraw();  // calls draw loop once to re-graph w/ new good vals
  }  // end if
  else // just put 0's in a row -- wouldn't plot, but would appear in table
  { TableRow newRow = volTab.addRow();
    newRow.setString("min", "0");    // (col index / key,value)
    newRow.setString("mV", "0");
    newRow.setString("mA", "0");
  }  // end else

}  // end serialEvent

void keyPressed()  // was if (keyPressed) in draw{}, same body actions
{                   // presume it runs in event thread
  // I use 's' to save data, exit; n to make new pt; z to clear graph
  // Win: 
  if (key == 's') { 
    saveTable(volTab, "C:\\Users\\alexM\\Documents\\Processing\\Sketchbook\\SerialStringReader6\\data\\newV.csv"); 
    exit();
  }
  // if (key == 's') { saveTable(volTab, "data/newV.csv"); exit(); } // ok for Mac; need full path for PC

  //    if (key == 'n') // draw new point each time it's pressed
  //      { 
  //       stroke(0);  // draw data darker
  //       ellipseMode(CENTER); // center on data pt
  //       ellipse(counter*60+60,counter*40+50,7,7);
  //       redraw(); // run draw loop once to make graph base, works here or above
  //       counter++;
  //      } // end if
  if (key == 'z')  // used to clear graph, now just --> redraw from stored data
  {
    // background(255);
    // counter = 1;
    redraw();
  } // end if
  else myPort.write(key);
  delay(100);  // avoids repeat reads of key & repeat sends by Ardu
}  // end kP
