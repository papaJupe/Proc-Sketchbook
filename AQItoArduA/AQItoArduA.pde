/* 
 AQItoArduA -- call PHP to get AQI, send return strings to Ardu to display
 Context: Processing
 
 Uses handshaking to manage serial data flow to/from the Ardu, loadStrings 
 from PHP on local server, Serial object/ port; Pfont, frameRate to control looping
 */

import processing.serial.*;     // import the Processing serial library

Serial myPort;              // The serial port
String[] aqiString = new String[5];      // string array from PHP with aqi and time
aqiString[0] = "someshit";
String substr;

void setup() 
  {
    size(240, 120);        // set the size of the applet window - w,h
    println(Serial.list());     // List all the available serial ports
  
    // get the name of your port from the serial list.
    // Change the 0 to the number of the serial port 
    // to which your microcontroller is attached:
    String portName = Serial.list()[0];
    // open the serial port:
    myPort = new Serial(this, portName, 9600); // need to match Ardu rate
  
    // will read bytes into a buffer until you get a linefeed (ASCII 10):
    // myPort.bufferUntil('\n');
  
    // use the second (sans serif) font available to the system:
    PFont myFont = createFont(PFont.list()[1], 14); // font, fontSize
    textFont(myFont); 
    frameRate(5);   // draw loops x / second
  }  // end setup

void draw() // loops repeatedly, albeit slowly
  {
    // set the background and text fill color for the applet window:
    background(#044f6f);  // clears it each loop
    fill(255);
    if (aqiString[0] != null)
    text(aqiString[0], 10, 20);  // writes info string to app window
    
 if (keyPressed)  // any key press GETs info (parsed string) from PHP page
                 // sends it over Serial to Ardu to display
  { 
    println("getting data\n");
    //String[] aqiString = loadStrings("http://localhost/Sites/PHP/webScraperB.php");
      String[] aqiString = loadStrings("http://localhost/Sites/PHP/timeNinfo.php");
    substr = aqiString[0];
    myPort.write(substr);
    println(substr);
    delay(100);  // avoids repeat reads of key & repeat sends by Ardu
  }

}  // end draw
