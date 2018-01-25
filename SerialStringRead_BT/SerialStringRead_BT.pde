/* 
 Serial String Read BT mod from, Igoe MTT ch2, proj2
 Context: Processing
 
 Pairs with Ardu doing SensorReader sending int data strings; Ardu sends a string
 when it gets a char sent from Proc; e.g. KeyPressed code; mod to send/recv 
 repeatedly;
 Also reads strings sent from Energia sketch like ReadBattVolt2LCD for rough monitor
 of batt dc. Also used w/ Ardu USsr04megaSerTxBT and various BT modules trying
 to get transparent wireless serial Ardu to PC/Mac. Works w/ H3 (dual 2/4 mode) which
 w/o much config has BT 2 SPP service: using added Broadcom BT multi dongle on iMac,
 I turn on BT, pair w/ H3, then can set code to open one of its ser ports 
 /dev/cu.H3SPPDev et al. Will auto-connect when ser port active, disconnect when I 
 close applet. team Leno PC with CSR BT multi dongle also can set up Ser port
 and connect to it (Ardu ser. mon.)
 
 Reads in a string of characters from a serial port until it gets a linefeed (ASCII 10).
 Then splits the string into sections separated by commas. Then converts the sections 
 to ints, and prints them out. or can print string packets. Handshaking possible so
 Ardu just responds when key pressed, or I send prompt from here using timer
 
 created 19 July 2010 by Tom Igoe -- minor mods by AM 1506, 1611, 1711
 */

import processing.serial.*;     // import the Processing serial library

Serial myPort;                 // init the serial port
String inputString = "";   // trimmed input string
String resultString = "";   // parsed string from input data
PFont f;                  // to display text in window
long previousMillis = 0;
int duration = 500;  // request data 2x/sec

void setup() 
{
  size(300, 130);             // set x,y size of the applet window
  f = createFont("Arial", 14);
  //textFont(f);  // font used in applet window
  println(Serial.list());     // prints (available) serial ports to console
  textFont(f); fill(254);
  // get the # of your port from the serial.list.
  // The first port in the serial list on (mac-pro) 
  // is generally the Arduino module, so open Serial.list()[0].
  // Use correct # for your machine; on Win7 seems to be [1] 
  // on iMac msp6989 is [4] cu.usbmodFD143 or [9] tty.usbmodFD143
  //  and Ardu is [1]cu or [3]tty; BT module [0, 2] H3 mod [1..3]

  String portName = Serial.list()[2];
  // open the serial port:
  myPort = new Serial(this, portName, 9600);
  // applet can only seize port if not in use: close Ardu IDE or set it
  // to use different port than the board is using;
  // when you Quit Proc. applet releases port, so Ardu can reconnect

  // set Serial to read bytes into a buffer until you get a linefeed (ASCII 10):
  myPort.bufferUntil('\n');
}  // end setup

void draw() 
{
  // set the background for the app window to dk blu-gray, w/ white text:
  background(#004466);  // not in setup because in draw loop it clears,
  // otherwise text just overwrites, but doesn't clear old text
//  textFont(f);
//  fill(#ffffff);  // text is white against blue-gray

  // get new value from Ardu's sensor over Serial if it's time
  if ( millis() > previousMillis + duration )
  {
    myPort.write('A'); // was 0 ? null ascii
    // println("Sensor request sent");
    delay(5);
    // while (myPort.available () < 0); // do nada while -1
    // while read doing nothing as buffer cleared by ser event fx
    //    while (myPort.available () > 0) 
    //    {
    //      print((char)myPort.read());
    //      println("..got something");  // why not printing
    //    }
    previousMillis = millis();     
    // read bytes store # in val
    //      val = myPort.read()*128 + myPort.read(); 
    //      println(val);  // to console
  }   // end if time to prompt

  // display parsed result string in applet window if anything to show:
  if (resultString != "") 
    text(resultString, 24, height/2);  // what,x,y
  else text(inputString, 24, height/2); // won't show if too evanescent
  delay(100);
}  // end draw

// serialEvent  method is run automatically by the Processing sketch
// whenever the buffer reaches the byte value set in the bufferUntil() 
// method in setup()

void serialEvent(Serial myPort) // watch myPort for events, buffer fill
{ 
  // read/clear serial-in buffer -- use if data comes as str of chars
  String inputString = myPort.readString(); // was readStringUntil('\n'),
  // supposed to exclude final \n, but no difference here +/- trim

  // trim space, return, linefeed, from the input string, using Java meth.
  inputString = inputString.trim(); // was =trim(inputString)-- didn't work w/ flt
  // clear resultString, assign new value
  resultString = "";
  if (inputString != "") resultString = inputString;

  // split the input string at commas
  // and put the tokens into [int,flt,str] array sensors[]: all types work, but
  // String sensors[] = split(inputString, ',');    // str best for getting floats

  // add the values to the result string: name + value
  // for (int sensorNum = 0; sensorNum < sensors.length; sensorNum++) 
  //  {
  //    resultString += "Sensor " + sensorNum + ": ";
  //    resultString += sensors[sensorNum] + "\t";
  //  }  // end for

  //    resultString += "elapsed min. ";  //  just the numbers with spaces
  //    for (int sensorNum = 0; sensorNum < sensors.length; sensorNum++) 
  //    {
  //      resultString += sensorNum + ": ";
  //      resultString += sensors[sensorNum] + "  ";  // spaces work, tabs don't
  //    }  // end for

  // print something to console; draw can print something to applet window
  // println(resultString);
  println(inputString);  // to console -- trimmed, unparsed
}  // end serEvent

