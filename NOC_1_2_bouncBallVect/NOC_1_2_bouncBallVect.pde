// orig in The Nature of Code

// mod Example 1-2: Bouncing Ball, with PVec class holding all vars

Pvec ball;    // the object that will move around, has location and change params
 
void setup() 
{
  size(300,300);
  background(255);
  ball = new Pvec(width/2,height/2); // start mid field
} // end setup

void draw() 
{
  noStroke();
  fill(255,20);  // overlay bkgnd with transparent white, so old balls fade out
  rect(0,0,width,height);
  
  // Add the x & y changes to the location vars
  ball.x = ball.x + ball.xrate;
  ball.y += ball.yrate;
      /// reverse course at edges
  if ((ball.x > width) || (ball.x < 0)) 
    {
      ball.xrate *= -1;
    }
  if ((ball.y > height) || (ball.y < 0))
    {
      ball.yrate *= -1;
    }

  // draw circle at x,y location
  stroke(0);
  fill(175);
  ellipse(ball.x,ball.y,16,16);
}


