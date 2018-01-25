/* Processing UDP example to send and receive binary data
 https://thearduinoandme.wordpress.com/tutorials/esp8266-send-receive-binary-data/
 -- hacked by Ray B. to display the UDP broadcast from ESP8266 primary bd
 hacked by AM to test I/O w/ Ardu Mega + ESP shield, send 2 bytes, get back something
 rec for Proc3, works OK w/ Proc2; this mod sends u or d for servo on Ardu
 */

import hypermedia.net.*; // this isn't nl Proc lib, but seemed to work
// I added UDP lib OK to Proc2 w/ lib manager, named UDP not this 
//http://ubaa.net/shared/processing/udp/udp_class_udp.htm  -- for wifi comm

String ip = "192.168.2.5";  // ESP8266 bd's remote IP address it got by ? DHCP
int port = 8888;    // must = destination device 'localport' - any unused port
long previousMillis = 0;
int interval = 5000; //  interval for auto send

UDP udp;   // from 1st import, ? some java hidden lib in hypermedia

void setup() {   // 'create a new datagram connection on port ___'
  // ? meaning Proc is responder, other device opens udp link (udp.begin)
  // no, there's no constant link, sketch actually sends prompt then listens
  udp = new UDP(this, 8884);  // my port, ardu only displays 
  // last 3 digits, but really needs all 4 digits
  // so I manually added # to ardu code for remotePort -- fixed w/ lib edit
  udp.listen( true );
}

void draw() {  // sends @ interval, just trigger UDP response from remote
  // or send different cmd for different responses ?
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
    message[0] = 45; // 0 is null, must be non-null to work, 45 is -
    message[1] = 117;  // was 0,1, this is small u 
    udp.send(message, ip, port);
  }
  if (key == 'd')
  {
    byte[] message = new byte[2];
    message[0] = 45; // 0 is null, should it be something? 45 is -
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

void receive( byte[] data )   // < default handler
{    // incoming data prints to console, could do other stuff w/ it

  if(data.length == 2)  // reconstruct a 16 bit int from bytes
    {   // proc byte[] max val 127
    int val = data[0]*128 + data[1];
    println(val);  // don't want \n until all data prints
     }
   else {
  for (int i=0; i < data.length; i++)
    {  //print(data[i]); // 2 bytes + 0 if string sent
      //println(i +"\t" + data[i]);
      print(char(data[i])); // if data is char[] prints chars, nothing if null
      // print(str(data));  //prints byte val of chars including null @ end
    }  // end for
   }  // end else
 println(); 

}  // end receive

