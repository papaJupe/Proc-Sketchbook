// mod from 1-11 to improve tracking

// a Mover object, declare here so both can use ?
Mover mover;

void setup() 
{
  size(600,300);
  mover = new Mover();  // make one
}

void draw() 
{
  background(255);  // clear every loop
  // Update the location
  mover.update();
  // Display the Mover
  mover.display(); 
}

