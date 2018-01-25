/* mod from NOC 1-11 to track smoother, stop when there; this simplifies by
 making veloc vect = mouse - mover, so it starts fast, slows to 0 when it gets there
*/
class Mover 
{

  // The Mover tracks location, velocity, and acceleration in these vars
  PVector location;
  PVector velocity;
  PVector accel;
  // The Mover's maximum speed
  float topspeed;
  
     // constructor takes no args
  Mover() 
  {
    // Start in the center
    location = new PVector(width/2,height/2);
    velocity = new PVector(0,0);
    topspeed = 7; // i guess this means 7 px / draw loop
  }
      // methods convert vars to a drawable obj which tracks mouse Loc then draw it
  void update() 
  {
    
    // Compute a vector that points from location to mouse
    PVector mouse = new PVector(mouseX,mouseY);
    PVector accel = PVector.sub(mouse,location);
    
//    // to damp any motion if close to mouseLoc, prev way using accel
//    if (accel.mag() > 15)  
//        {
//        // Set magnitude of acceleration
//        //accel.setMag(0.2);
//        accel.normalize();  // I think this takes out effect of distance on amt of accel
//              // leaving just direction; then mult by # or factor that varies w/ distance
//        //accel.mult(0.5);  // oscillates & orbits w/ any fixed mult
//        accel.mult(15/accel.mag());  // incr multiplier when close, reduces oscill
//        }            // but doesn't stop it
//      else {  // or make veloc ~ distance (accel), goes to 0 when there
//           //accel.normalize();
//          //PVector p = PVector.div(velocity,-2);  sort of works, still oscill
//           //accel.mult(p.mag());  // .mag returns float, should work
//           velocity.set(accel.get()); // drops veloc as it gets nearer 
//           accel.set(0,0); // so it doesn't change veloc below, stops oscill @ rest
//      }
           
    // much more effective: velocity ~ to acceleration vs. accel adding to it
    // velocity.set(accel); // tracks perfectly, no oscill
    velocity.set(PVector.div(accel,2)); //must use static meth to get this value
    // Limit the velocity by topspeed
    velocity.limit(topspeed);
    // Location changes by velocity
    location.add(velocity);
  }

  void display() 
  {
    stroke(0);
    strokeWeight(2);
    fill(120);
    ellipse(location.x,location.y,48,48);
  }  // end display

}  // end class



