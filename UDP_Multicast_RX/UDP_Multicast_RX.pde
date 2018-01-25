/* Processing UDP example to send and receive binary data
 https://thearduinoandme.wordpress.com/tutorials/esp8266-send-receive-binary-data/
 -- hacked by Ray B. to display the UDP broadcast from ESP8266 primary bd
 ? for Proc3, seems OK in Proc2; simple test sends 1 on press 0 on release, works
 OK with primary Feath-Huzzah;
*/
 
import hypermedia.net.*; // this isn't a lib, but seemed to work
 // I added UDP lib OK to Proc2 w/ lib manager, named UDP not this 
 //http://ubaa.net/shared/processing/udp/udp_class_udp.htm  -- for wifi comm

String ip = "192.168.2.5";     // the remote IP address of ESP8266 bd
int port = 8888;    // must = destination device 'localport' - any unused port
long previousMillis = 0;
int interval = 500; //  interval for redraw (? repeats)

UDP udp;   // from above ? or UDP lib I have

void setup() {
  udp = new UDP(this, 8888);
  udp.listen( true );
}

void draw() {  // was sending every interval, to trigger UDP response from remote
//    if (previousMillis < millis() - interval) {
//      previousMillis = previousMillis + interval;
//
//        byte[] message = new byte[2];
//        message[0] = 0; message[1] = 0;
//        udp.send(message, ip, port);
//    }
}

void keyPressed() {
  if (key == 'f')
  {
      byte[] message = new byte[2];
      message[0] = 0; message[1] = 65;  // try printing char? A=65
      udp.send(message, ip, port);
  }
}

void keyReleased() {
  if (key == 'f') {
      byte[] message = new byte[2];
      message[0] = 67; message[1] = 66;
      udp.send(message, ip, port);
  }
}

//void receive( byte[] data, String ip, int port )    // < extended handler

void receive( byte[] data )   // < default handler
{    // incoming data prints to console, could do other stuff w/ it
  for (int i=0; i < data.length; i++)
  { 
     print(char(data[i]));
  }
  println();  // don't want \n until all data prints
}
