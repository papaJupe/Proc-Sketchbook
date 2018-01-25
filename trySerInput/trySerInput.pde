/* Averaging Java--> Proc w/ Scanner fails, not enabled in Proc 2.x anyway
  -- another try with java.io + sys.in.read, very little working here
 */
import java.lang.System;  // may need for sys.in, doesn't help tho
import java.io.*;  // ? what, why this needed if it is

char ch = 0;
char letter = 0;

void setup()
{  
  size(400, 200); // doesn't show
  frameRate = 10;
  println("type a char or two:");  // this prints OK, but
   try {
       do{   // no sign this is doing anything
          // ch = (char) System.in.read();  // method blocks until input
        ch = key;
         if ((ch >= 'A' && ch <= 'z') || key == ' ') 
         {
			letter = ch;  // a char var?
			// words = words + key;  // String or char array?
          }  // end if
    // print the letter to the console
    print(ch);    
         } while( ch != 'k');  // keying k should stop doing
       } // end try
  catch(java.io.IOException ex) {println("failed w/ " + ex);}
  println("got a k");
  
}  // end setup

void draw()  
{     
 
} // end draw

