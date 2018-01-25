/* 
 AQItoArduA -- call PHP to get AQI from web, send return strings to Ardu to display
 Context: Processing
  Uses handshaking to manage serial data flow to/from the Ardu, loadStrings 
 from PHP on local server, Serial object/ port; Pfont, frameRate to control looping.
 B adds display of Ardu feedback in Proc. and more control of Ardu wake up with key press
 */

import processing.serial.*;     // import the Processing serial library

Serial myPort;              // The serial port
String[] aqiString = new String[5];      // string array from PHP with aqi and time
String substr, substr1;

void setup() 
  {
    size(300, 150);        // set the size of the applet window - w,h
    println(Serial.list());     // list the available serial ports
  
    // get the name of your port from the serial list.
    // Change the 0 to the number of the serial port 
    // to which your microcontroller is attached:
    String portName = Serial.list()[0];
    // open the serial port:
    myPort = new Serial(this, portName, 9600); // need to match Ardu rate
    // println(myPort);  // shows its internal name, not what we call it
    
    // prompt for app window at start up
    aqiString[0] = "press any key to update"; // why can't I put this before setup?
  
    // use the second (sans serif) font available to the system:
    PFont myFont = createFont(PFont.list()[1], 14); // font, fontSize
    textFont(myFont);
       // this reads incoming bytes into a buffer until a linefeed (ASCII 10):
    myPort.bufferUntil('\n');  // then makes a Serial event
    
    frameRate(20);   // draw loops x / second
    
  }  // end setup

void draw() // loops repeatedly at frameRate
  {
    // set the background and text fill color for the applet window:
    background(#044f6f);  // clears it each loop
    fill(255);  // white text
    if (aqiString[0] != null)
    text(aqiString[0], 10, 20);  // writes prompt or 1st data string to app window
    if (aqiString[1] != null)
    text(aqiString[1], 10, 40); // still null at start, then gets filled and prints
    
    // print stuff coming back from Ardu
    String inputStr = myPort.readStringUntil(10);  // \n = 10
    if (inputStr != null)  // it's null when buffer empties
    print(inputStr);  // uses newlines coming in
    
                  
 if (keyPressed)  // any key press GETs info (parsed string) from PHP page
                 // sends it over Serial to Ardu to display
    { 
      println("getting data");  // to Proc. console
      myPort.write('x'); // wakes Ardu up only
      // loadStr(URI) returns Str[] -- if PHP is sending, elements can be
      // delimited by \r,\n, or both; <br> prints "as text" but needed by browser
      
      aqiString = loadStrings("http://localhost/Sites/PHP/webScraperB.php");
      // if you redeclare the array inside this if{}, the values in draw{block} aren't reset
      // aqiString = loadStrings("http://localhost/Sites/PHP/timeNinfo2.php");
      substr = aqiString[0]; // incoming data, now stripped of \r and \n
      substr1 = aqiString[1];
      myPort.write(substr+"\n"+substr1);  // send serial to Ardu, this is OK but
      // myPort.write(aqiString);  // won't compile, .write claims it wants int to send
      println(substr +"\n" + substr1);  // to console, 2 lines, need \n for linebrk
        // println(aqiString); // console shows [0]"first elem" [1]"second elem"
      delay(100);  // avoids repeat reads of key
    }  // end if KeyPress
    
  }  // end draw
