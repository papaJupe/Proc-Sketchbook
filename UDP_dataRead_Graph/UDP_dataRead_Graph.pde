/* 
 Processing: UDP dataRead Graph -- send and receive binary data 
 over wifi from sensor on Ardu with wifi shield or perhaps primary
 ESP module (Feather-Huzzah? mod from Serial Data Read to Graph et al
 graph & display data -- Ardu code sends US data: USsr04 mega UDP TX
 
 hacked by AM to test I/O w/ Ardu Mega + ESP shield, send 2 bytes, 
 get back 2 data bytes, graph them; index OOB failures w/ GpointsArray
 I couldn't fix, so when full, I empty the point array and start over
 (kluge)
 
 rec for Proc3, works OK w/ Proc2 and old graph lib (may be faulty)
 */

import hypermedia.net.*; // this isn't nl Proc lib, but seemed to work
import grafica.*;  // Proc2 needs old version like 1.2 using Java6

// create plot instance
GPlot plot;

// initialise global variables for plot
int i = 0; // global var that tracks data point, array index, x value
int points = 350; // number of points to display at a time
// actually init size of the GpointsArray, maybe can grow
int totalPoints = 400; // number of points on x axis, array max size
float noise = 0.05; // added noise, not used apparently
float period = 0.25;  // ? how used to init data or what ?
PFont f;

String ip = "192.168.2.5";  // ESP8266 shield's remote IP addr, got by DHCP
int port = 8888; // must = destination device 'localport'
long previousMillis = 0;
int interval = 200; //  interval for redraw, request data send
int dist = 0; // incoming data, global, receive fx sends to draw

UDP udp;   // from 1st import but I don't understand how, where stored
GPointsArray points1 = new GPointsArray(points); //(kluge, 'global' now)

void setup() {  // udp setup to listen, so it seems remote inits connection?
  udp = new UDP(this, 8884);  // my port #, ardu only sees/can addr/send 
  // to last 3 digits, but may need 4 digits here for some reason?
  // so I manually add this # to ardu code for remotePort<-lib edit fixed
  udp.listen( true );

  // set size of the graph window
  size (640, 480);
  // GPointsArray points1 = new GPointsArray(points); was here
  // initialize all points to 0 (kluge, don't init, leave empty)
  //for (i = 0; i < points; i++) points1.add(i, 0);
  // Create the plot
  plot = new GPlot(this);
  plot.setPos(25, 25); // set position of top left corner of plot
  plot.setDim(500, 350); // set plot size
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

void draw() 
{  // sends @ interval, triggers UDP response from remote; data 
  // comes thru receive fx, reset global val
 
  // set window background, other graph stuff
  background(150);
  // draw the plot
  plot.beginDraw();
  plot.drawBackground();
  plot.drawBox();
  plot.drawXAxis();
  plot.drawYAxis();
  plot.drawTopAxis();
  plot.drawRightAxis();
  plot.drawTitle();
   // Add the array of points to the plot (kluge added)
  plot.setPoints(points1);
  plot.getMainLayer().drawPoints();
  plot.endDraw();
  // if i > allowed size reset to zero & (kluge) clear array
  if (i >= totalPoints) 
     {
       i=0; points1.removeRange(0, totalPoints);;  // clear array
     }
    // display new distance # in applet window if anything to show:
    fill(#3333CC);
    if (dist != 0) 
      text(dist, 240, height/2);  // what,x,y
      
  // send trigger packet if it's time, receive() gets & plots new data
  if (millis() > previousMillis + interval)
  {
    byte[] message = new byte[2];
    message[0] = 65; // sends a A
    message[1] = 0;
    udp.send(message, ip, port);
    delay(10); // enough to ensure new data ? can get new global val in loop
    previousMillis = millis();
  }
    
  delay(90);

}  // end draw
  // used in testing and debug only
void keyPressed() {
  if (key == 'f')
  {
    byte[] message = new byte[2];
    message[0] = 65; 
    message[1] = 0;  // was 0,1, this prints char? A=65
    udp.send(message, ip, port);
  }
}

void keyReleased() {
  if (key == 'f') {
    byte[] message = new byte[2];
    message[0] = 67; 
    message[1] = 66;  // this sends CB
    udp.send(message, ip, port);
  }
}

// extended handler, shows source of data
//void receive( byte[] data, String ip, int port ) 

void receive( byte[] data )   // default handler, byte max val 127 in Proc
{    // incoming data prints & graphs, could do other stuff w/ it

  //  for (int i=0; i < data.length; i++)
  //  {   println(i +"\t" + data[i]);
  //     // println(char(data[i])); // if data is char[]
  //  }

  if (data.length == 2)
    {
      dist = data[0]*128 + data[1];
      println(dist + "\t" + i); // to console
       // Add new point at end of the array (kluge)
      i++;
      points1.add(i, dist);
    }

// orig plot update always got index OOB exceptn. above kluge works
//    plot.addPoint(i, dist);
//    // Remove the first point in array
//    plot.removePoint(0);

}   // end recv fx

