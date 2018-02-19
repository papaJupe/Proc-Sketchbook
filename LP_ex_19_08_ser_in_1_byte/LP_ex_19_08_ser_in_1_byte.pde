
/* LP Example 19-8 (says 19-7 in book): Reading from serial port 
-- single bytes sent from Ardu, as in SensorReaderGrapher using .write
Uses: Serial, port config, serialEvent, port read
*/
import processing.serial.*;

int val = 0; // To store data from serial port, used to color background
Serial port; // The serial port object

void setup() 
{
  size(200, 200);

  // In case you want to see the list of available ports
  //println(Serial.list());

  // I use the first available port (might be different on your computer)
  port = new Serial(this, Serial.list()[0], 9600);
}

void draw() 
{
  // The serial data is used to shade the background (0-255) 
  background(val);
}

// Called whenever there is something available to read
void serialEvent(Serial port) 
{
  // Data from the Serial port is read in serialEvent() using the read() 
  // function and assigned to the global int variable val:
    val = port.read();  // reads bytes one at a time, so OK if Ardu is sending
      //  (0-255) with .write, but not if he's sending chars with .print
    // For debugging
    println("Raw Input: " + val);
}
