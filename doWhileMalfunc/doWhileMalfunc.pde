/*
do while malfunction, seems to block key entry, ? other problems
may not function well in Proc, altho does partially work
*/

char ch = 'q';

void setup()
{   // helps to click in window, to keep key input from here
//  size(200, 200);
//  background(200);

  println("first doo: type a letter");
  // frameRate(5);
}// end setup

void draw() 
{

    //do {  // runs but faulty, not supported in Proc?, blocks input from keybd
    // while(!keyPressed);  // should hold here until some press
    // but seems to block input, hangs here w/ 100% cpu
    if (keyPressed) ch = key; // works here, won't ever happen in do block
    // keyPressed(); // press should place key into ch, same as above
    delay(500);  // undocumented in Proc but seems to workzzzzz
    println("KP is: " + ch);
    delay(500);
   // }//endoo 
     // while(ch == 'q');     // if true, do continues to loop, doesn't work  
     // default q keeps while true until something new comes
    if(ch != 'z') println(ch + " is not z");
    else {println("done, got a z"); exit();}   // stop on z

}  // end draw
void keyPressed()  // does same as above if()
{
ch = key;
}
