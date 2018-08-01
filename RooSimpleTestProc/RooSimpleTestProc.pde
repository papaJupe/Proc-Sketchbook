
/*
 * roombacomm.SimpleTest
 *
 *  Copyright (c) 2005 Tod E. Kurt, tod@todbot.com
 *
 
 A simple test of RoombaComm and RoombaCommSerial function.
 -- in Processing environment -- runs but complains that it
 didn't and generates list of errors, I don't understand, coming
 from outdated serial lib in .jar; possibly needs earlier Proc v.
 *
 */

import roombacomm.*;
// import roombacomm.net.*;

// String portname =  "/dev/cu.SLAB_USBtoUART";
String portname =  "/dev/cu.usbserial-FTDWL41H";
//String portname =  "/dev/cu.usbserial-FTF70AK2";

RoombaCommSerial roombacomm = new RoombaCommSerial();
boolean hwhandshake = false;
roombacomm.waitForDSR= false;

if ( ! roombacomm.connect( portname ) ) {
  System.out.println("Couldn't connect to "+portname);
  System.exit(1);
}      

System.out.println("Roomba startup on port "+portname);
roombacomm.startup();
roombacomm.pause(50);
roombacomm.control();
roombacomm.pause(30);

System.out.println("Checking for Roomba... ");
if ( roombacomm.updateSensors() )
System.out.println("Roomba found!");
else
System.out.println("No Roo found. Is it turned on?");


System.out.println("Playing some notes");
roombacomm.playNote( 72, 10 );  // C
roombacomm.pause( 200 );
roombacomm.playNote( 79, 10 );  // G
roombacomm.pause( 200 );
roombacomm.playNote( 76, 10 );  // E
roombacomm.pause( 200 );

System.out.println("Spinning left then right");
roombacomm.spinLeft();
roombacomm.pause(500);
roombacomm.spinRight();
roombacomm.pause(500);
roombacomm.stop();

System.out.println("Going forward, then back");
roombacomm.goForward();
roombacomm.pause(1000);
roombacomm.goBackward();
roombacomm.pause(1000);
roombacomm.stop();


System.out.println("Moving via send()");
byte cmd[] = {
  (byte)RoombaComm.DRIVE, 
  (byte)0x00, (byte)0xaa, (byte)0x00, (byte)0x00
};
roombacomm.send( cmd ) ;
roombacomm.pause(500);
roombacomm.stop();
// this should go straight but curves to R
cmd[1] = (byte)0xaa;
cmd[2] = (byte)0x03;
roombacomm.send( cmd ) ;
roombacomm.pause(500);
roombacomm.stop();

System.out.println("Disconnecting");
roombacomm.disconnect();


