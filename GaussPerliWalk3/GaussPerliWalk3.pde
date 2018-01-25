// Nature of Code modif I.4 example v 3 -- Gauss-Marko vs Perlin walks plotted vs. time
// Gauss-Marko could walk off limits, but Perlin used as is, will always stay in mapped range

// import java.util.Random;

// Random generator = new Random();  // not using, but could

void setup()   // only want to draw one screenful
{ 
  size(640, 640);
  float Yloc = 160;  // start pt for Markov series
  float perY = 480;  // start pt for Perlin series, middle of lower chart
  float perT = 0.5; // the time param we augment to step thru P noise

  int timX = 0;  // will step 0-640 by 2
  background(0);  

  fill(254, 200);

  while (timX < 641)  // fill the window then stop
  {  
    noStroke();  // for charts, yeStroke for mid-line

      // plot actually inverted because higher Y = lower on chart
    // make the Markov series, Yloc starts @ 160, then goes up/down w/ gaussian incrmt
    Yloc += randomGaussian() * 8; // add or subtr a little
    ellipse(timX, Yloc, 4, 4);
    // does same as above
    // gets a gaussian random number w/ mean of 0 and standard deviation of 1.0
    // float yloc = (float) generator.nextGaussian();

    // make a plot using P noise, (also a rand 0-1 that varies smoothly w/ (time))
    // map the 0-1 value to high-low of chart range (inverting); cannot leave this range
    perY = map(noise(perT), 0, 1, 636, 324);  // 
    ellipse(timX, perY, 4, 4);   // draw small circle at noisy height

    // draw horiz line at screen middle
    strokeWeight(2);
    stroke(200, 200, 100);  // dk yellow
    line(0, height/2, width, height/2);
    timX += 2;
    perT += 0.05;  // low val gives slow smooth movement, bigger =  bigger jump
  }  // end while
  //     println ("done it");
  fill(255);  // label the charts
  text("random walk using Gaussian increment", 10, 30);
  text("Perlin walk", 10, 350);
}   // end setup

void draw() 
{
}

