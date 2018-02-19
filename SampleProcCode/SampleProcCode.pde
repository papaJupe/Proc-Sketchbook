/* sampleProcessingCode snippets
   font, et.al. set in ~/Library/Processing/preferences.txt
   others in
   /Applications/Processing.app/Contents/Resources/Java/lib/theme.txt
*/

void setup(){
  size(240,480);  // applet window , w, ht px
  float out;   // no problem putting ints into map, tho default is flt
  for (int i=200; i <620; i= i+50)
    {     // map returns float, so cast if you want (int)
      out = map(i, 200, 600, 0, 100);  
      // println(String.format("%d maps to %d", i, out)); // print to console
      println ("or " + i + " maps to " + out); // same
    }
    frameRate(30); // ~30 loops/sec
}

void draw() {
  // set the background and fill color for the applet window:
  background(#044f6f); // dark blu gray
  fill(#ffffff); // white stroke(200, 200, 100);  // dk yellow
  // show list of some fonts in the window:
 for(byte i=0; i <16; i++)
 {  text(PFont.list()[i],10,(20+i*15)); }


// make String obj and print
--------------------------------
String resultStr;   // add to it
resultStr += "sensor "+ sensNum +":" + "\t" + valVar;
//print to console if all elements are str or have toString val
println(resultStr) or println("mixup " + var1 +"\t" + var 2)
print to app window
if(resultStr != null) text(resultStr, 10, height/2) -- str,x,y location

some ways to handle key presses for input
------------------------------------------------
 is there no way to use System.in +/- Scanner?
void keyPressed() {  // keyPressed is also boolean var = true when down,
 also kP() fx called by event loop each key press
  // The variable "key" always contains the value 
  // of the (1) most recent key pressed

  if ((key >= 'A' && key <= 'z') || key == ' ') {
    letter = key;  // a char var?
    words = words + key;  // String or char array?}

    // print the letter to the console
    println(key);}
--------------------------------------
The solution is to correctly differentiate between coded and uncoded keys, then 
use the key variable to check for values such as ENTER, RETURN, and BACKSPACE:

void keyPressed() {

  if (key==CODED) 
  {  // non ascii control chars, UP DOWN LEFT RIGHT
    if (keyCode == SHIFT) println("shift");
    else if(keyCode == CONTROL)println("ctrl");
    else if(keyCode == ALT) println("alt");  //ignore other CODED
  } else {
    if (key == BACKSPACE println("1: backspace"); // can use to clear a char from string, v. samProCode
    else if (key == DELETE) println("2: delete");
    else if (key == RETURN || key == ENTER) 
    println("4: return");
    else println("5: " + key);}
}}

display keybd input to app window
-------------------------------
PFont f;
// Variable to store text currently being typed 
String typing = ""; 
// Variable to hold saved text & print to app window 
String saved = "";
void setup() 
  { size(300, 200);
  f = createFont("Arial", 16);
  }  // end setup
void draw() 
  { background(255); 
  int indent = 25;
  // Set the font and fill for text 
  textFont(f); fill(0);
  // show prompt, what's typed, and saved
  text("Click here and type.\nHit return to display what you typed.", indent, 40);
  text(typing, indent, 90); text(saved, indent, 130);
  }  // end draw

save keybd input to string, backspace enabled
-----------------------------
void keyPressed()
  saved ="";  // clears saved, improves consistency
{ // If the return key is pressed, save the input and clear var 
if (key == '\n') 
  {
  saved = typing; 
  typing = "";   // clear typed string
  } 
  if ((key == DELETE || key == BACKSPACE) && (typing.length()>1))
  // remove the last char typed
  typing = typing.substring(0,typing.length()-1);
else 
  { //Otherwise, concatenate the String
  typing = typing + key;
  }
}

// number format (Proc only, Java uses DecimalFormat fx)
-------------------- 
nf(int/flt or [], digits) or (num, left, right)
nf(200,6) --> 000200  nf(PI,3,3) --> 003.141

read data from serial port:
--------------------------
import processing.serial.*;
Serial myPort;  // a serial port object
void setup() {
  // List available serial ports if needed at first
  println(Serial.list());
  // Open the port you want at the rate you want:
  myPort = new Serial(this, Serial.list()[0], 9600);
}
void draw() {
  while (myPort.available() > 0) {
    int inByte = myPort.read();  // one byte at a time
    println(inByte);

convert serial/udp string data to integer
--------------------------------------------
v. SerialDataRead to Graph, UDP_test_RX_TX

parse digits from string containing it:
-----------------------------------
String sentence = "John is a happy 11, isn't he? U2?";
String[] m = match(sentence, "\\d+");
if (m != null)  // Found!
{
  println("1st found: " + m[0]);  // m = an array of matching strings
  println("total found: " + m.length);
}

GET something from a URL, which can be PHP script:
------------------------
String[] getBak = loadStrings("http://localhost/Sites/PHP/timeNinfo.php");
println(getBak);  // no html header, just what was echoed as strings, one per
              // numbered line, e.g. \r and \n stripped automatically (all control ch?)
[0] "<html><head></head><body>"
[1] "hollow whirl<br>"
[2] "iniget: America/Denver<br>"
[3] "today is: 2015-07-21 17:52:15<br>"
[4] "</body></html>"
//getBak is an array holding Strings, so you get its length with
println(getBak.length) -- 5 in this case
for length of its 1st String, use
println("1st str len is " + getBak[0].length()); -- 25 in this case

Table methods
-------------------
loadTable -- public Table loadTable(String filename)
 Parameters:  filename - name of a file in the data folder or a URL.

loadTable -- public Table loadTable(String filename, String options)
 Options may contain "header", "tsv", "csv", or "bin" separated by commas. 
 e.g. "csv,header"
 
saveTable -- public boolean saveTable(Table table, String filename)
 Parameters: table - the Table object to save to a file
          filename - the filename to which the Table should be saved

saveTable -- public boolean saveTable(Table table, String filename, String options)
 Parameters: options - can be one of "tsv", "csv", "bin", or "html"