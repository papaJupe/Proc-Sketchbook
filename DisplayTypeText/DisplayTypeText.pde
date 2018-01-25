/*
keyboard text entry, save to string, display string in app window
Uses: Pfont, createFont, textFont, text(display), keyPressed
*/

PFont f;
// Variable to store text currently being typed 
String typing = ""; 
// Variable to store saved text when return/enter is hit 
String saved = "no saved";

void setup() 
  { size(300, 200);
  f = createFont("Arial", 16);
  }  // end setup

void draw() 
  { background(0,0,180); // dark blue
  int indent = 25;
  // Set the font and fill for text 
  textFont(f); fill(254);
  // Display prompt and typing or saved text
  text("Click here and type.\nHit return to save what you typed.", indent, 40);
  text(typing, indent, 90); 
  text(saved, indent,160);
  }  // end draw

void keyPressed() 
{  
 saved = ""; // clear this var as typing begins
// If the return key is pressed, save typing and clear it 
if (key == '\n') 
  {
  saved = typing; 
  typing = "";   // clear typed string
  } 
if ((key == DELETE || key == BACKSPACE) && typing.length()>1)
  // remove the last char typed, if >1 there
  typing = typing.substring(0,typing.length()-1); // 2nd param can never go neg
else 
  { // Otherwise, concatenate the String
  typing = typing + key;
  }
}  // end kP
