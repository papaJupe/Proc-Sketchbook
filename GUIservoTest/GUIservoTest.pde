/* 
 GUI servo test, template combines code of blankGUI and
 Proc2 UDP mega Servo GUI control over wifi -- send / recv data;
 folder has gui tab made w/ GUI builder before, has handler
 that prints value to lable
 mod by AM for I/O w/ Ardu Mega + ESP shield, send bytes, get
 back ack; rx tx mod sends key u or d to control servo on Mega,
 this adds GUI slider read/send servo angle from slider;
 later mod add joystick button controls
 */

// G4P library for graphic control
import g4p_controls.*;
import java.awt.*;  // to set font

// for UDP
import hypermedia.net.*; // this isn't nl Proc lib, prob. java pkg'd libs

String ip = "192.168.3.51";  // ESP8266 shld remote IP addr, via AP's DHCP
int port = 8888;  // must = destination device 'localport' - any unused port
long previousMillis = 0;
int interval = 500; //  interval for auto send, just for debug here 
Font f;
UDP udp;   // from hypermedia import

public void setup() 
{
  udp = new UDP(this, 8884);  // my port, ardu only displays 
  // last 3 digits, but really needs these 4 digits
  // so I manually add this # to ardu code for remotePort
  udp.listen( true );

  size(300, 220, JAVA2D);
   // Create the AWT font
  f = new Font("Arial",Font.PLAIN, 18);
  //setFont(f);
  createGUI();  // makes stuff from code in gui tab
  customGUI();
}   // end setup

void draw() 
{    // sends @ interval, to trigger UDP response from remote,
  // or send some data
  frameRate(5); // use instead of delay to control redraw rate
  background(120, 120, 220);

//  if (millis() > previousMillis + interval) 
//  {
//        byte[] message = new byte[2];
//        message[0] = 65;   // 'A' = 65
//        message[1] = 66;   // 'B'
//  }     // end if

    // can I put string into udp.send, Y
    String message = tilt.getValueS();
    udp.send(message, ip, port);
    previousMillis = millis();
// 
} // end draw

  // Use this method to add additional statements
  // to customise the GUI controls, would gui obj handler work here too?
  public void customGUI()
  {
    // handler from example, needs to be added inside the object code cf tilt_change
    //public void handleSliderEvents(GValueControl slider, GEvent event) 
    // {   println("int value sdr1:" + sdr1.getValueI() + " float val sdr5:" + sdr5.getValueF());
    //  }
    //
  }  // end custom

  void keyPressed() {  // works, but not if draw is sending continuously
    if (key == 'u')
    {
      byte[] message = new byte[2];
      message[0] = 45; // was 0,1, both must be non-null to work, 45 is -
      message[1] = 117;  //  this is small u 
      udp.send(message, ip, port);
    }
    if (key == 'd')
    {
      byte[] message = new byte[2];
      message[0] = 45; // 0 is null, needs to be non-null, 45 is -
      message[1] = 100;  // was 0,1, this is small d 
      udp.send(message, ip, port);
    }
  }  // end keyPress handler

  void receive( byte[] data )   // < default handler, byte[] max 127
  {    // incoming data prints to console, could do other stuff too

    for (int i=0; i < data.length; i++)
    {  //print(data[i]); // 2 bytes + 0 if string sent
      //println(i +"\t" + data[i]);
      print(char(data[i])); // if data is char[] prints chars, nothing if null
      // print(str(data));  //prints byte val of chars, 0 for null @ str end
    }
    println(); 
    //  if(data.length == 2)  // reconstruct a 16 bit int from bytes
    //  {
    //  int val = data[0]*128 + data[1];
    //  println(val);  // don't want \n until all data prints
    //   }
  }  // end recv data handler

