/* Proc2 UDP mega Servo control over wifi -- send / recv data,

 mod by AM for I/O w/ Ardu Mega + ESP shield, send bytes, get
 back ack; this mod sends u or d to control servo on Mega,
 later mods try add GUI, joystick button controls
 Ardu code: ESP82shield mega UDP tx rx
 */

import hypermedia.net.*; // this isn't nl Proc lib, prob. java pkg'd libs

String ip = "192.168.3.53";  // ESP8266 shld remote IP address, via AP's DHCP
int port = 8888;    // must = destination device 'localport' - any unused port
long previousMillis = 0;
int interval = 5000; //  interval for auto send, just for debug here 

UDP udp;   // from 1st import, ? some java hidden lib

void setup() {
  udp = new UDP(this, 8884);  // my port, ardu only displays 
  // last 3 digits, but really needs these 4 digits
  // so I manually add this # to ardu code for remotePort
  udp.listen( true );
}

void draw() {  // sends @ interval, could trigger UDP response from remote,
                // or do nothing as here, just tokens for testing
  if (millis() > previousMillis + interval) 
  {
    // previousMillis = previousMillis + interval;
    byte[] message = new byte[2];
    message[0] = 65;   // 'A' = 65
    message[1] = 66;   // 'B'
    udp.send(message, ip, port);
    previousMillis = millis();
  }
}

void keyPressed() {
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
}  // end if keyPress

//void keyReleased() {
//  if (key == 'f') {
//    byte[] message = new byte[2];
//    message[0] = 67; 
//    message[1] = 66;  // this sends CB
//    udp.send(message, ip, port);
//  }
// }

// extended handler, shows source
//void receive( byte[] data, String ip, int port ) 

void receive( byte[] data )   // udp default handler, byte[] max 127
{    // incoming data prints to console, could do other stuff w/ it

  for (int i=0; i < data.length; i++)
  {  //print(data[i]); // 2 bytes + 0 if string sent
    //println(i +"\t" + data[i]);
     print(char(data[i])); // if data is char[] prints chars, nothing if null
    // print(str(data));  //prints byte val of chars including null @ end
  }
 println(); 
//  if(data.length == 2)  // reconstruct a 16 bit int from bytes
//  {
//  int val = data[0]*128 + data[1];
//  println(val);  // don't want \n until all data prints
//   }
}
