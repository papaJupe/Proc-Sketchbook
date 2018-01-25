/* Proc2 Servo mega Tx Rx BT, control via BT I/O
 
 mod by AM for I/O w/ Ardu Mega + BT mod, send bytes, get
 back ack; this mod sends u or d to control servo tilt,
 later mods added GUI, joystick button controls w/ Enjoyable
 app (looks like it sends capital letter but really small)
 
 Ardu code: Servo Mega tx rx Bluetooth
 Use: config BT mod on Ardu, enable BT on PC, Pair, for Joystk, open
 Enjoyable, enable actions >, then run this, ID port, click in applet
 window for joystick to work; once Paired, hc-xx says 'not connected'
 but when you reopen serial connection it auto-connects again
 
 */
 
import processing.serial.*;     // import the Processing serial library

Serial myPort;

void setup() 
{  
  size(300, 150);  // ? need to click in applet for keys/joyst to work
  // get the # of your port from the serial.list.
  println(Serial.list());  // SPP port from BT2 connection

  String portName = Serial.list()[2];  // 
  // open the serial port:
  myPort = new Serial(this, portName, 9600); // speed = BT ser config
  // applet can only seize port if not in use: ? close Ardu/Energia IDE or set it
  // to use different port than the board is using; may not need to do this.
  // when you Stop applet, it releases port, loses BT comm, keeps Pair? Y

  // set Serial to read bytes into a buffer until you get a linefeed (ASCII 10):
  myPort.bufferUntil('\n'); // used to see ack
  frameRate(8); // ~10 loops/sec
}  // end setup

void draw() 
{  // sends key val @ interval, ? needs 2B slower than Ardu loop
  if (keyPressed && (key == 'u')) myPort.write('u');
  if (keyPressed && ( key== 'd')) myPort.write('d');
}  // end draw

void keyPressed() {
  if (key == 'u')
  {
    myPort.write('u');
  } else if (key == 100)  // ascii for small d
  {
    myPort.write(100); // small d
  }
  delay(100); // stop draw repeats too quick
}  // end if keyPress

void serialEvent(Serial myPort) // watch myPort for events, buffer fill
{ 
  // read & clear serial-in buffer -- use if data comes as str of chars
  String inputString = myPort.readString(); // was readStringUntil('\n'),
  // supposed to exclude final \n, but no difference here +/- trim

  // trim space, return, linefeed from the input string, using Java meth.
  inputString = inputString.trim(); // was trim(inputString)-failed w/ flt

  println(inputString);  // to console -- trimmed, unparsed
}  // end serEvent

