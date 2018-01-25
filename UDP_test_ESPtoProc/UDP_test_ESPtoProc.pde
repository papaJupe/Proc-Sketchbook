/* Processing UDP example to send and receive binary data w/ remote
ESP board; each press of f key toggles between LED flashing 2/second ON/OFF; 
when any other key is pressed, LED lites & goes OFF when released. 
must click on applet window for keys to work

import hypermedia.net.*;   //  lib does not exist here, does this work, Y, why?

UDP udp; // define the UDP object  // I have UDP lib

String ip = "192.168.2.7"; // remote device IP addr - ? DHCP from wifi router
int port = 8888;         // UDP destination port on device

long previousMillis = 0;
byte light = 0;
int interval = 500; // sets rate for flicker var to invert
byte flicker = 0;
byte held = 0;

void setup() {
  udp = new UDP( this, 8888 ); // create new datagram connection on port 8888
  //udp.log( true ); //  print the connection activity
  udp.listen( true ); // and wait for incoming message
}

void draw()  // automatically repeat as loop does ?
{
  if (flicker == 1) 
  {
    if (previousMillis < millis() - interval) 
    {
      previousMillis = previousMillis + interval;
      if (light == 0) 
      {
        byte[] message = new byte[2];
        message[0] = 0;
        message[1] = 0;
        udp.send(message, ip, port);
        light = 1;
      } else 
      {
        byte[] message = new byte[2];  
        message[0] = 0;
        message[1] = 1;
        udp.send(message, ip, port);
        light = 0;
      }
    }
  }
}

void keyPressed() {  // bounce may send multiples ?
    // if toggles flicker on/off each press of f, else something else
  if (key == 'f') {
    if (flicker == 1) {
      flicker = 0;
      byte[] message = new byte[2];
      message[0] = 0;
      message[1] = 0;
      udp.send(message, ip, port);
      light = 0;
    } else {
      flicker = 1;
    }
  } else {  // other key press sends a 1, bounce = possible multiples
    if (flicker == 0 && held == 0) {
      byte[] message = new byte[2];
      message[0] = 0;
      message[1] = 1;
      udp.send(message, ip, port);
      held = 1;
    }
  }
}

void keyReleased() {  // release of other key turns lite off
  if (key != 'f') {
    if (flicker == 0) {
      byte[] message = new byte[2];
      message[0] = 0;
      message[1] = 0;
      udp.send(message, ip, port);
      held = 0;
    }
  }
}

void receive( byte[] data ) // <-- default handler of incoming from .listen
//void receive( byte[] data, String ip, int port ) <-- extended handler
{
  for (int i=0; i < data.length; i++)
  {
    print(char(data[i]));
  }
  println();
}

