
/*
 * rooSimpleTestProc2
 *
 * adapted from RooSimpleTest -- sends some cmds using .write
 *
 -- test of serial connection, wired, BT (HC05) -- both OK
 * first, run separate listSerPort sketch to see portname/indices,
 then paste below
 can't use RC class (in new tab) w/o making an object (tried/failed
 class refs to use vars and meths)
 */

import processing.serial.*;
Serial myPort;

void setup()
{
  // portname = USB dongle OR module PC's onboard BT is paired to
  //String portName = "/dev/cu.usbserial-FTDWL41H"; /dev/cu.HC-05-DevB
  //  or put index of same in .list
  String portName = Serial.list()[2];

  myPort = new Serial(this, portName, 57600);

  //if ( ! RooComm.connect( portname ) ) {
  //  System.out.println("Couldn't connect to "+portname);
  //  System.exit(1);
      

System.out.println("Roomba start on port "+portName);
//RooComm.startup();
//RooComm.pause(30);
//RooComm.control();
//RooComm.pause(30);

myPort.write((byte)128);
delay(300); 
myPort.write((byte)130); // puts into safe
delay(300);


//System.out.println("Checking for Roomba... ");
//if ( RooComm.updateSensors() )
//System.out.println("Roomba found!");
//else
//System.out.println("No Roo found. Is it turned on?");


System.out.println("Playing some notes");
//RooComm.playNote( 72, 10 );  // C
//RooComm.pause( 200 );
//RooComm.playNote( 79, 10 );  // G
//RooComm.pause( 200 );
//RooComm.playNote( 76, 10 );  // E
//RooComm.pause( 200 );
byte sng[] = {  // define 1 note songs
  (byte)140, 3, 1, (byte)72, (byte)10, 
  (byte)141, 3      // play it back
};                      
myPort.write( sng );
delay(200);
sng[3] = (byte)79; 
myPort.write( sng );
delay(200);
sng[3] = (byte)76;
myPort.write( sng );
delay(200);

System.out.println("Spinning left then right");

//RooComm.spinLeft();
// G1 left spin    R1 small left spin
byte cmd[] = {
  (byte)137, 
  (byte)0x00, (byte)0xba, (byte)0x00, (byte)0x01
};
myPort.write( cmd );
delay(500);

//RooComm.stop();
cmd[1] = (byte)0x00;
cmd[2] = (byte)0x00;
myPort.write( cmd );
delay(2000);

//RooComm.spinRight();
G1 spin R    R1 small R spin
cmd[2] = (byte)0xba; 
cmd[3] = (byte)0xff;
cmd[4] = (byte)0xff;
//RooComm.send( cmd ) ;
myPort.write( cmd );

delay(500);
//RooComm.pause(1000);

//RooComm.stop();
cmd[1] = (byte)0x00;
cmd[2] = (byte)0x00;
myPort.write( cmd );
delay(2000);

System.out.println("Going forward, then back");

//RooComm.goForward();
//RooComm.pause(1000);
//RooComm.goBackward();
//RooComm.pause(1000);
//RooComm.stop();


System.out.println("Moving via send()");
// should be straight fwd slow but gray1 = turn R; 
// R1 small fwd

cmd[2] = (byte)0xba;
cmd[3] = (byte)0x80;
cmd[4] = (byte)0x00;

//RooComm.send( cmd ) ;
myPort.write( cmd );

delay(500);
//RooComm.pause(1000);

//RooComm.stop();
cmd[1] = (byte)0x00;
cmd[2] = (byte)0x00;
myPort.write( cmd );
delay(2000);

// should be straight back but is gray 1:120+ turn L
// R1 small back

cmd[1] = (byte)0xff;
cmd[2] = (byte)0x36;
myPort.write( cmd );
//RooComm.send( cmd ) ;
//RooComm.pause(1000);
delay (500);


//RooComm.stop();
// go back?
//cmd[1] = (byte)0xff;
//cmd[2] = (byte)0xaa;
//myPort.write( cmd );
//delay(1000);

// stop -- yes
cmd[1] = (byte)0x00;
cmd[2] = (byte)0x00;
myPort.write( cmd );

// power down works on G1, R1; must rewake both w/ button or wires
myPort.write((byte)133);
delay(30);
System.out.println("Disconnecting");
//RooComm.disconnect();
}

void draw() {
}

