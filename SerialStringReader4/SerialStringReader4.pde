/* 
 Serial String Reader 4 -- 
 Pairs with Ardu's SensorReader4 sending int csv data strings autonomously,
 or when it gets a char sent from Proc; v.i. KeyPressed code, if handshaking 
 
 Reads a string of characters from the serial port until it gets a linefeed (ASCII 10).
 Then splits the string into tokens separated by commas, puts into str array and prints
 them to console and app window. Makes a Table to hold the values, saves it on key 's';
 serialEvent meth graphs the values to the window as they arrive. v.5 will try to read 
 stored vals from Table in draw loop.
 
 Uses: Serial,bufferUntil,readString,split,trim,Table & methods,gwoptic lib-Graph2D
 */

import processing.serial.*;     // import the Processing serial library
import org.gwoptics.graphics.graph2D.Graph2D;

Graph2D grph;  // obj from above lib to make graph base
int counter = 1; // how many times n (new pt) key pressed

Serial myPort;          // the serial port
String resultString;  // string receives the input data
VolTable volTab;    // table will store incoming vals
PFont f;

void setup() 
{
 size(930,540); // window size 90 px larger than graph

  // Creating the Graph2D object:
  // arguments are the parent object, xsize, ysize, cross axes at zero pt
  grph = new Graph2D(this, 840, 450, false); 

  // Defining properties of the X , Y Axes
  grph.setYAxisMin(12.4f);
  grph.setYAxisMax(12.85f);  // 450 px ht = 450 mV
  grph.setXAxisMin(0);
  grph.setXAxisMax(280); // 840 px/3 = 280 min, 3 px/min
  grph.setXAxisLabel("minutes");
  grph.setYAxisLabel("voltage");
  grph.setXAxisLabelAccuracy(0);  // # of decimal places shown
  grph.setXAxisTickSpacing(30);
  grph.setYAxisTickSpacing(0.1);
  grph.setYAxisMinorTicks(4); // # between each major tick, 5 divis
  
  // Offset of the top left corner of the plotting area
  // to the app window origin -- top left corner
  // (> 50 so you can see the y-axis label)
  grph.position.x = 60;
  grph.position.y = 20;

  // println(Serial.list());     // prints (available or all?) serial ports to console

  // get the # of your port from the serial.list.
  // The first port in the serial list on my computer (mac) 
  // is generally the Arduino module, so I open Serial.list()[0].
  // Use correct # for your machine

  String portName = Serial.list()[0];
  // open the serial port:
  myPort = new Serial(this, portName, 9600); // speed must match Ardu's
  // applet can only seize port if not in use: close Ardu IDE or set it
  // to use different port than the board is using;
  // when you Quit Proc. applet releases port, so Ardu can reconnect

  // set Serial to read bytes into a buffer until you get a linefeed (ASCII 10):
  myPort.bufferUntil('\n');
  // table holds incoming values as strings
  volTab = new VolTable();
  background(255);
  f = createFont("Arial", 16);
  textFont(f);
}  // end setup

void draw() 
{  // background(255);  // if here, clears all, doesn't show new pts
    grph.draw();
    stroke(190); // very lt line for theoretic dc curve 12.5v @ 240"
    line(70,70,780,370); // x= 60+min*3, y = 20+(12850-mV)

  // display input string in the window if anything to show:
  if (resultString != null)  //kluge to show new vals cleanly 
    { //noStroke(); // better if I read all vals from Table each loop
      fill(255);
      rect(195,30,200,30); // white out small area      
      fill(0);
      text(resultString, 200, 50);  // what,x,y
    }
   noLoop(); // just draw once
}  // end draw

        
void keyPressed()  // was if (keyPressed) in draw{}, same body actions
  {
       // I use 's' to save data, exit; n to make new pt; z to clear graph
    if (key == 's') { saveTable(volTab, "data/newV.csv"); exit(); }
//    if (key == 'n') // draw new point each time it's pressed
//      { 
//       stroke(0);  // draw data darker
//       ellipseMode(CENTER); // center on data pt
//       ellipse(counter*60+60,counter*40+50,7,7);
//       redraw(); // run draw loop once to make graph base, works here or above
//       counter++;
//      } // end if
    if (key == 'z')  // clear graph when it's pressed
      {
       background(255);
       // counter = 1;
       redraw();
      } // end if
    delay(100);  // avoids repeat reads of key & repeat sends by Ardu
  }  // end kP
    
// serialEvent method is run automatically by the Processing sketch
// whenever the buffer reaches the byte value set in the bufferUntil() 
// method in setup(): (presumably has its own thread)

void serialEvent(Serial myPort) // watch myPort for events
{ 
  // read the serial buffer
  String inputString = myPort.readString(); // was readStringUntil('\n')
  // supposed to exclude final \n, but no difference here +/- trim

  // trim space, return, linefeed, from the input string, using Java meth.
  inputString = inputString.trim(); // was =trim(inputString) -- failed w/ flt

  // split the input string at the commas
  // and put the tokens into [int,flt,str] sensors[] array: all types work, but
  String sensors[] = split(inputString, ',');    // str best for getting floats
  // reset resultString
  resultString = "min:mV:mA ";
  // add the values to the result string:
  for (int sensorNum = 0; sensorNum < sensors.length; sensorNum++) 
    {
      resultString += sensors[sensorNum] + "\t";
    }  // end for
  
  println(resultString); // to the console. also to app window w/ draw loop
  //println(inputString);  //unparsed, untrimmed

  // add new vals to the table, may want some timer or throttle control of this
  // makes new row entry and fills key:val slots (col slot, value to put there)
  if (sensors.length == 3) // no new row if not a full array, or get OOB ex
    { // background(255); // if here, shows only the new pts
    TableRow newRow = volTab.addRow();
    newRow.setString(0, sensors[0]);    // what's the col now to fill
    newRow.setString("mV", sensors[1]); // 1st arg = col index or its string key
    newRow.setString("mA", sensors[2]);
  
    // add new vals to the graph; should put this in draw and read full table there
   stroke(0);  // draw data darker
   ellipseMode(CENTER); // center on data pt
   ellipse(60+int(sensors[0])*3,20+12850-int(sensors[1]),7,7); // x=60+min*3, y=20+(12850-mV)
   redraw();  // run draw loop once to make graph w/ new vals, works here or above
    }  // end if
}  // end serEvent

