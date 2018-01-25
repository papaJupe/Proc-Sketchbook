 /* 
 Serial String Reader Grapher, Igoe MTT Ch3, proj 5
 Reads int (as string of characters) from a serial port, (e.g. sent by Ardu running
 SensorReaderGraph), until it gets a linefeed (ASCII 10).
 Then trims spaces and returns, and graphs ints to app window.
 Ardu SensorReader from Ch2 sent more complex int string from buttons and 2 sensors; 
 this Proc sketch just handles a series of single ints
 not used now --> Handshaking added so Ardu just sends line when a key is pressed
 
 created 19 July 2010
 by Tom Igoe -- minor mods by AM 1507
 */

import processing.serial.*;     // import the Processing serial library

Serial myPort;                 // the serial port
String inString;           // string for incoming
float sensorValue = 0;      // the value from the sensor
float xPos = 0;             // horizontal position of the graph
float prevSensorValue = 0;  // previous value from the sensor
float lastXPos = 0;         // previous horizontal position

void setup() 
{
  size(400,300);             // set the size of the applet window
  // println(Serial.list());     // list all the available serial ports in console

  // get the name of your port from the serial list.
  // The first port in the serial list on my computer (mac) 
  // is generally the Arduino module, so I open Serial.list()[0].
  // Change the 0 to the number of the serial port 
  // to which your microcontroller is attached:

  String portName = Serial.list()[0];
  // open the serial port:
  myPort = new Serial(this, portName, 9600);  // must be same speed as Ardu's
        // Ardu must have closed its connection for Proc. app to seize port
        
  // read bytes into a buffer until you get a linefeed (ASCII 10) char:
  myPort.bufferUntil('\n');

  // set app window background (dk blue) and smooth drawing:
  background(#543174);  // put here, so new data will overwrite & old not cleared
}  // end setup

void draw() 
{
  if (keyPressed)  // any key press sends \return to stimulate
    {              // Ardu to send a line -- not used if sending data automatically
      myPort.write('\r');
      delay(100);  // avoids repeat reads of key & repeat sends by Ardu
    }

}  // end draw

// serialEvent method is run automatically by the Processing applet
// whenever the buffer reaches the byte value set in the bufferUntil() 
// method in setup():

void serialEvent(Serial myPort) 
{ 
  // read the serial buffer (char string sent by Ardu) into inString:
  String inString = myPort.readStringUntil('\n');

  if (inString != null) // eventually parse to extract int from string
  {  
    // trim off any whitespace:
    inString = trim(inString);
    // convert to a float and map Ardu anal. range to the screen height:
    sensorValue = float(inString); // could be int, but map outputs float
    sensorValue = round(map(sensorValue, 0, 1023, 0, height));
    println(sensorValue);
    drawGraph(prevSensorValue, sensorValue);

    // save the current value for the next time:
    prevSensorValue = sensorValue;
  } // end if
}  // end serialEvent

void drawGraph(float prevValue, float currentValue) 
{
  // subtract the values from the window height
  // so that higher numbers get drawn higher:
  float yPos = height - currentValue;
  float lastYPos = height - prevValue;

  // draw the line in a pretty color:
  stroke(#C7AFDE);  // almost white, could use ffffff
  line(lastXPos, lastYPos, xPos, yPos); // does line connect points ?

  // at the edge of the screen, go back:
  if (xPos >= width) 
    {
      xPos = 0;
      lastXPos = 0;
      background(#543174);  // erases old trace
    } // end if
  else 
    {
      // increment the horizontal position:
      xPos++;
      // save the current position for next time:
      lastXPos = xPos;
    }   // end else
}   // end drawGraph

