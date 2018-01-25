
// Graphing background pattern
// layout vars, maybe just in setup ?
int marginX = 60; // left, right margins
int marginY = 50; // top,bot margins
int majDiv = 100;
int minDiv = 20;

void setup()
{
  size(700, 600);
  background(66);  // dark bkgnd
  // 5 major div, 5 minor div
  // minor H lines, draw first
  stroke(240, 100, 100);
  for (int i = marginY; i<= height-marginY; i+=minDiv)
    line(marginX, i, width-marginX, i);
  // then overlay with lighter lines
  stroke(250);
  for(int i = marginY; i<=height-marginY; i+= majDiv)
  line(marginX-10, i, marginX+20, i);
  
  // vertical x scale time markers adapt to width, so I calc
  int timeSpan = width - 2*marginX;
  int minWid = int(timeSpan/30);
  int majWid = int(timeSpan/10);
  stroke(99);
  //strokeWeight(1);
  for(int i = marginX+minWid; i <= width-marginX; i +=minWid)
  line(i,marginY,i,height-marginY-1);
  stroke(250);
    for(int i = marginX; i <= width-marginX; i +=majWid)
  line(i,height-marginY-15,i,height-marginY+10);
} // end setup

