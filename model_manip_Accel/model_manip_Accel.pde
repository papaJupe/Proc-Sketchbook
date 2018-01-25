/*
Proc sketch adapted for FRC breakout board from sloppy code at:
 http://codeyoung.blogspot.com/2009/11/adxl345-accelerometer-breakout-board.html
 -- Ardu gets accel readings over I2C, sends by Serial to Proc to display graphic
 -- needs fast graphics: won't run in SL at all; virt Win 7 runs very slowly
 Uses: Serial receive, buildShape, rotate shape, Integer.parseInt
 */


//import processing.opengl.*; irrelevant for Proc v.>2
import processing.serial.*;

Serial serPrt;
byte[] buff;
float[] r;  // array holds the transformed z,x values used in rotation of shape
float protz, protx;   // default inits to 0 ?

int SIZE = 150, SIZEX = 200;
// These offsets are chip specific and vary.  Play with them.
int OFFSET_X = -9, OFFSET_Y = 9;   

static int counter = 0; // set here, then keeps value in fx

void setup() 
{
  size(200, 150, P3D); // can't use var for applet window size
  // println(Serial.list());     // List all the available serial ports  
  // get the name of your port from the serial list in console
  // Change the 0 to the index of your serial port in the list
  String portName = Serial.list()[0]; // my virt Win 7: 0 = COM3
  // open the serial port: can use name like "COM4" found from Device Manager
  serPrt = new Serial(this, portName, 9600); // need to match Ardu rate

  buff = new byte[64];   // only need to buffer one line, so why was size 128 ?
  r = new float[3];
}


void draw() 
{ // exit();  // just for port setup, no looping
  perspective( 45, 4.0/3.0, 1, 5000 );

  translate(SIZEX/2, SIZE/2, -400);  // center stuff on applet window
  background(0);
  // buildShape(protz, protx);  // not sure why here, faster without it

  int bytes = serPrt.readBytesUntil((byte)10, buff);  // put data into bytes array
  String myStr = (new String(buff, 0, bytes)).trim(); // removes stuff at ends
  if (myStr.split(" ").length != 3) 
  {
    println(myStr);  // only print if not correct length
    return;  // restarts loop?
  }
  setVals(r, myStr);
  // ignore the accel z changes, r[2], just look at L-R, Front-Bak tilts
  float z = r[0], x = r[1];  // treating accel's x as Proc z, accel's y as Proc x
  if (abs(protz - r[0]) < 0.02)   // noise filtering ?
    z = protz;
  if (abs(protx - r[1]) < 0.02)
    x = protx;
  background(0);  
  buildShape(z, x);

  protz = z;     
  protx = x;
  if (counter % 100 == 0)
    println(r[0] + ", " + r[1] + ", " + r[2]);
  counter++;
}  // end draw

void buildShape(float rotz, float rotx) 
{
  pushMatrix();
  scale(6.6.12);
  rotateZ(rotz);
  rotateX(rotx);
  // stroke(0);  // black 1 px thick
  noStroke(); // no outline on boxes; def. is 1 pixel, but looks much wider
  fill(255);   // white box

  box(60, 10, 10);
  fill(0, 255, 0);  //  grn box
  box(10, 9, 40);
  translate(0, -10, 20);
  fill(255, 0, 0);  // red box
  box(5, 12, 10);  
  popMatrix();
}

void setVals(float[] r, String s) // convert int vals from Ardu to radian values for rotation
{
  int i = 0;  // 1st int (x) goes to {roc's z (rot around axis perpend. to display plane)
  // 2nd int (y) goes to x here (rot around horiz axis line); was way too sensitive before, ?why
  // 3rd int (z) not used, but can print it
  r[0] = -(float)(Integer.parseInt(s.substring(0, i = s.indexOf(" "))) +OFFSET_X)*HALF_PI/256;
  r[1] = -(float)(Integer.parseInt(s.substring(i+1, i = s.indexOf(" ", i+1))) + OFFSET_Y)*HALF_PI/512;
  r[2] = (float) Integer.parseInt(s.substring(i+1));  // z param not used in display, raw #
}