/** StoreValuesinArraylikeStack
 *orig: Proc/Help/Basic/Input/Storing Input 
 * 
 * Move the mouse across the screen to change the position
 * of the circle. The x,y locs of the mouse are put
 * into an array and played back every frame. Between each
 * frame, the newest values are added to the end of x,y arrays
 * and the oldest value is deleted. Draw() displays the array
 * continuously, oldest data drawing smallest circle
 */
 
int num = 60;
float mx[] = new float[num];
float my[] = new float[num];

void setup() 
  {
  size(640, 360);
  noStroke();
  fill(255, 153); // white circles, fairly opaque
  frameRate(2);  // was 60, I slowed way down to see action and print values, trying to
          // understand how %mod functions work
  
  }

void draw() 
{
  background(51); // screen cleared each frame, near black
  
  // frame redraws advance through the array, putting new data in last element. 
  // Using modulo (%) like this is faster than shifting values.
  // looping use of modulo to write and read data changes only one element per loop
  
  int which = frameCount % num;  // 0 ->59, adding 1 each loop, @60 restarts 0->59
  mx[which] = mouseX;  // loc values go into each successive array slot
  my[which] = mouseY;
   
  for (int i = 0; i < num; i++) // 0->59, must complete for loop to advance
    { // indx [which] is latest to get overwritten above, so
      // which+1 holds oldest value set in the array)
      int index = (which+1 + i) % num;  //this cycles 0->59 also, each
       // frame, starting with oldest data, up to latest; when for loop
       // completes, the frame can advance giving a new frameCt and which
      ellipse(mx[index], my[index], i, i); // oldest data draws smallest circle
       // trying to follow the numbers; each for loop prints a line
       println("framCt= " + frameCount + "\t which= " + which + "\tindx= "+ index);
    }
}
