/* 
 Monski Pong with handshaking
 Context: Processing
 
 Plays monski pong!
 Expects a comma-separated serial string of sensor values :
 * left (0 - 1023)   -- use Ardu SensorReader to get real min/max values
 * right(0 - 1023)
 * reset(0 - 1)
 * serve(0 - 1)
 * carriage return, newline
 
 Uses: Serial,Pfont,text to window,keyPressed,readStringUntil, handshaking to 
 manage serial data flow to/from the Ardu,serialEvent,split
 */


import processing.serial.*;     // import the Processing serial library

Serial myPort;                 // The serial port
String resultString;           // string for the results
// why should L/R paddle not be ints? map works fine w/ ints, outputs float
int leftPaddle, rightPaddle;   // variables for the flex sensor values
byte resetButton, serveButton;    // variables for the button values
int leftPaddleX, rightPaddleX;   // horizontal positions of the paddles
byte paddleHeight = 50;           // vertical dimension of the paddles
byte paddleWidth = 10;            // horizontal dimension of the paddles
           // no good reason for large values not to be ints
int leftMinimum = 160;         // minimum value (AR) of the left flex sensor
int rightMinimum = 15;        // minimum value of the right flex sensor
int leftMaximum = 750;         // maximum value of the left flex sensor
int rightMaximum = 65;        // maximum value of the right flex sensor

byte ballSize = 10;     // the size of the ball (defined as rect in animate ball)
int xDirection = 1;    // the ball's horizontal direction. 
// left is –1, right is 1.
int yDirection = 1;    // the ball's vertical direction.
// up is –1, down is 1.
int xPos, yPos;        // the ball's horizontal and vertical positions

boolean ballInMotion = false;  // whether the ball should be moving

byte leftScore = 0;      // score for left paddle
byte rightScore = 0;     // score for right paddle

byte fontSize = 36;      // point size of the scoring font

void setup() 
{
  size(640, 480);             // set the size of the applet window
  // println(Serial.list());     // List all the available serial ports

  // get the name of your port from the serial list.
  // The first port in the serial list on Mac OS 
  // is generally my Arduino module, so I open Serial.list()[0]
  // Change the 0 to the number of the serial port 
  // to which your microcontroller is attached:
  String portName = Serial.list()[0];
  // open the serial port:
  myPort = new Serial(this, portName, 9600); // need to match Ardu rate

  // will read bytes into a buffer until you get a linefeed (ASCII 10):
  myPort.bufferUntil('\n');

  // initialize the sensor values:
  leftPaddle = height/2;  // middle of vertical span
  rightPaddle = height/2;
  resetButton = 0;
  serveButton = 0;

  // initialize the paddle horizontal positions:
  leftPaddleX = 30;
  rightPaddleX = width - 30;

  // set no borders on drawn shapes:
  noStroke();

  // start the ball in the center of the screen:
  xPos = width/2;
  yPos = height/2;

  // use the second (sans serif) font available to the system:
  PFont myFont = createFont(PFont.list()[1], fontSize);
  textFont(myFont); 

}  // end setup

void draw() // loops repeatedly
{
  // set the background and fill color for the applet window:
  background(#044f6f);
  fill(255);

  // draw the left paddle:
  rect(leftPaddleX, leftPaddle, paddleWidth, paddleHeight);

  // draw the right paddle:
  rect(rightPaddleX, rightPaddle, paddleWidth, paddleHeight);
  
  // calculate the ball's position and draw it:
  if (ballInMotion == true) 
  {
    animateBall();
  }
  // if (keyPressed)  // any key press sends \return to stimulate
  //  {                  // Ardu to send a line, not needed now
  //    myPort.write('\r');
  //    delay(70);  // avoids repeat reads of key & repeat sends by Ardu
  //  }
  
  // if the serve button is pressed, start the ball moving:
  if (serveButton == 1) 
  {
    ballInMotion = true;
  }

  // if the reset button is pressed, reset the scores
  // and start the ball moving:
  if (resetButton == 1) 
  {
    leftScore = 0;
    rightScore = 0;
    ballInMotion = true;
  }
  // print the scores:
  text(leftScore, fontSize, fontSize);
  text(rightScore, width-fontSize, fontSize);
}  // end draw

// serialEvent  method is run automatically by the Processing sketch
// whenever the buffer reaches the byte value set in the bufferUntil() 
// method in the setup():

void serialEvent(Serial myPort) 
{   // getting input values from serial stream

  // read the serial buffer:
  String inputString = myPort.readStringUntil('\n');

  // trim the carrige return and linefeed from the input string:
  inputString = trim(inputString);
  // clear the resultString:
  resultString = "";

  // split the input string at the commas
  // and convert the elements into integers in array:
  int sensors[] = int(split(inputString, ','));
  // if you received all the sensor strings, use them:
  if (sensors.length == 4) 
  {
    // scale the flex sensors' results to the paddles' range:
    // map outputs float, but int inputs are fine; just need to cast output to int
    leftPaddle = (int) map(sensors[0], leftMinimum, leftMaximum, 0, height);
    rightPaddle = (int) map(sensors[1], rightMinimum, rightMaximum, 0, height);

    // assign the switch values to the button variables:
    resetButton = (byte)sensors[2];
    serveButton = (byte)sensors[3]; 

    // add the values to the result string: nothing is done with it now, but could print to debug 
    resultString += "left: "+ leftPaddle + "\tright: " + rightPaddle;
    resultString += "\treset: "+ resetButton + "\tserve: " + serveButton;
  }  // end if sensors
  // send something to device via serial port to ask for data:
  myPort.write('\r');
}  // end serial event

void animateBall() 
{
  // if the ball is moving left:
  if (xDirection < 0) 
  {
    //  if the ball is to the left of the left paddle:
    if  ((xPos <= leftPaddleX)) 
    {
      // if the ball is in between the top and bottom 
      // of the left paddle:
      if ((leftPaddle - (paddleHeight/2) <= yPos) && 
        (yPos <= leftPaddle + (paddleHeight /2))) 
      {          
        // reverse the horizontal direction:
        xDirection =-xDirection;
      }
    }
  }  // end if Left
  // if the ball is moving right: 
  else 
  {
    //  if the ball is to the right of the right paddle:
    if  ((xPos >= ( rightPaddleX + ballSize/2))) 
    {
      // if the ball is in between the top and bottom 
      // of the right paddle:
      if ((rightPaddle - (paddleHeight/2) <=yPos) && 
        (yPos <= rightPaddle + (paddleHeight /2))) 
      {
        // reverse the horizontal direction:      
        xDirection =-xDirection;
      }
    }
  }  // end if Right

  // if the ball goes off the screen left:
  if (xPos < 0) 
  {
    rightScore++;
    resetBall();
  }
  // if the ball goes off the screen right:
  if (xPos > width) 
  {
    leftScore++;
    resetBall();
  }


  // stop the ball going off the top or the bottom of the screen:
  if ((yPos - ballSize/2 <= 0) || (yPos +ballSize/2 >=height)) 
  {
    // reverse the y direction of the ball:
    yDirection = -yDirection;
  }
  // update the ball position:
  xPos = xPos + xDirection;
  yPos = yPos + yDirection;

  // Draw the ball:
  rect(xPos, yPos, ballSize, ballSize);  // ball rect defined here by pos and size
}// end animate

void resetBall() 
{
  // put the ball back in the center
  xPos = width/2;
  yPos = height/2;
}  // end reset

