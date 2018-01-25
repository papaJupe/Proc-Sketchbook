/* timed drawing, failed with do / while or while -- seems to block key 
 entry, drawing -- limited fx in Proc, same with delay(); here I use conditional
 and delay to time-control drawing actions; or draw loop could call another timer
 function
 */

int ct = 0;

void setup()
{ 
  size(200, 200);
  background(90);

  println("get ready for some fun!!!");
  // frameRate(12);  // rate held down by delay, could use this instead
}// end setup

void draw() 
{  
  delay(200);  // slows loop some, but no point in >1 as redraws
           // of window only occur at term of draw loop
  background(90);  // clear and replace each loop
  if (ct < 70) 
    {
      fill(222); // make whitish rect
      rect(25, 25, 150, 150);
    }
  
  //  background(222);  
  // no point in 2nd uncondit bkgn redraw, only one shows
  if (ct > 50)
    {
      fill(0); // paint it black
      rect(40, 40, 120, 120);
    }
  ct++;
  fill(220);
  text("ct is " + ct, 10, 20);
  
  if (ct >= 100)  
       exit();   // then stop
}  // end draw

