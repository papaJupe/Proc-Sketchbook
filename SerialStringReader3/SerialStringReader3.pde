/* 
 Serial String Reader 3, from Igoe MTT ch2, proj2, major mods by AM 1512
 
 Pairs with Ardu's SensorReader3 sending int csv data strings autonomously,
 or when it gets a char sent from Proc; v.i. KeyPressed code; 
 
 Reads a string of characters from the serial port until it gets a linefeed (ASCII 10).
 Then splits the string into tokens separated by commas, puts into str array and prints
 them to console and app window. Handshaking w/ Ardu optional. Makes a Table to hold the
 values, saves it.
 Uses: Serial,bufferUntil,readString,split,trim,Table & methods,
 */

import processing.serial.*;     // import the Processing serial library

Serial myPort;                 // the serial port
String resultString;          // string receives the input data
VolTable volTab;    // table will store incoming vals

void setup() 
{
  size(480, 130);             // set the size of the applet window

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
}  // end setup

void draw() 
{
  // set background for the app window to dk blu-gray:
  background(#004466);  // why not in setup? because in draw loop it clears,
  // otherwise text just overwrites (doesn't clear old text)
  fill(#ffffff);  // text is white
  // display input string in the window if anything to show:
  if (resultString != null) 
    {
      text(resultString, 10, height/2);  // what,x,y
    }
  if (keyPressed)  // any key press sends char to stimulate
    {                // Ardu to send a line; not used if it's sending autonomously
      // myPort.write('z');  // I use 's' to save data, exit program
      if (key == 's') { saveTable(volTab, "data/newV.csv"); exit(); }
      delay(120);  // avoids repeat reads of key & repeat sends by Ardu
    }

}  // end draw

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
  resultString = "writing vals: ";
  // add the values to the result string:
  for (int sensorNum = 0; sensorNum < sensors.length; sensorNum++) 
    {
      resultString += sensors[sensorNum] + "\t";
    }  // end for
  // print resultStr to the console; also to app window w/ draw loop
  println(resultString);
  //println(inputString);  //unparsed, untrimmed

  // add new vals to the table, may want some timer or throttle control of this
  // makes new row entry and fills key:val slots (col slot, value to put there)
  if (sensors.length == 3) // no new row if not a full array, or get OOB ex
    {
    TableRow newRow = volTab.addRow();
    newRow.setString(0, sensors[0]);    // what's the col now to fill
    newRow.setString("mV", sensors[1]); // 1st arg = col index or its string key
    newRow.setString("mA", sensors[2]);
    }
}  // end serEvent

