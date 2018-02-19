/* SerialDataRead to Graph -- send serial bytes to stimulate response
 from device like Ardu w/ sensor which responds w/ 2 byte data. Plot 
 data to graph, works fine w/ Ardu Mega sketch USsr04megaSerTX sending
 ultrasound distances over USB UART serial or probably BT2 module
 Serial read code specific for 2 byte int, does not buffer input
 
 */

// import  libraries
import processing.serial.*;
import grafica.*;  // Proc2 needs old version like 1.2 for J6

// create plot instance
GPlot plot;

// initialise global variables
int i = 0; // variable that tracks point updates
int points = 499; // number of points to display at a time
int totalPoints = 500; // number of points on x axis
float noise = 0.05; // added noise, not used?
float period = 0.25;  // ? how used to init data or what ?
long previousMillis = 0;
int duration = 200;  //request data 5x/sec
PFont f;

// Serial object
Serial myPort;

void setup() {

  // init serial connection
  // println(Serial.list());
  String portName = Serial.list()[1];
  println("port:" + portName);
  myPort = new Serial(this, portName, 9600); // must match UART module,
     // probably not Ardu sketch's if using BT mod on Ardu
  
  // set size of the window
  size (740, 450);
  // create graph points object
  GPointsArray points1 = new GPointsArray(points);
  // initialize all points to 0
  for (i = 0; i < totalPoints; i++) points1.add(i, 0);

  // Create the plot
  plot = new GPlot(this);
  plot.setPos(25, 25); // set position of top left corner of plot
  plot.setDim(560, 350); // set plot size
  plot.setPointColor(#33CC33);  // RGB hex for green
  plot.setPointSize(4); // pixels
  // Set the plot limits (this will fix them)
  plot.setXLim(0, totalPoints); // set x limit
  plot.setYLim(0, 2000); // set y limit
  // Set the plot title and axis labels
  plot.setTitleText("Distance Sensor Example"); // set plot title
  plot.getXAxis().setAxisLabelText("x axis, sample #"); // x axis label
  plot.getYAxis().setAxisLabelText("Distance"); //  y axis label
  // Add the array of points to the plot
  plot.setPoints(points1);
  f = createFont("Arial", 14);
  textFont(f);  // font used in applet window
}  // end setup

void draw() {
  // set window background
  background(150);
  int val = 0;
  // draw the plot
  plot.beginDraw();
  plot.drawBackground();
  plot.drawBox();
  plot.drawXAxis();
  plot.drawYAxis();
  plot.drawTopAxis();
  plot.drawRightAxis();
  plot.drawTitle();
  plot.getMainLayer().drawPoints();
  plot.endDraw();

  // if i has exceeded the plot size reset to zero
  if (i > totalPoints) i=0;

  // get new value from sensor over Serial if it's time
  if ( millis() > previousMillis + duration )
  {
    myPort.write('A'); // was 0 which may be null ascii #
    //println("Sensor request sent");
     delay(5);
    while (myPort.available() < 0) {;}  // do nada while -1
    delay(5);
    while (myPort.available() > 0) // assumes 2 bytes, could test or buffer
    // to improve reliability of data
        {  // println("..got something");
         val = myPort.read()*128 + myPort.read(); // read bytes store # in val
          println(val);  // to console
        }
 
    // Add new point at the end of the array
    i++;
    plot.addPoint(i, val);
    // Remove the first point
    plot.removePoint(0);
    previousMillis = millis();
  }  // end if get new value

  // display result in appl window if anything to show:
  fill(#000000);
  if (val != 0) 
    text(val, 240, height/2);  // what,x,y

  delay(100);
}   // end draw

