/*
moves DardO according to mouse speed -- only mvmt within window counts
Uses:rectMode,rect,triangle,arc,ellipse,mouseX,moving avg
*/

byte end =22;  // travel end pt
byte mult;  // how much travel each loop
int dir = 1; // -1 or 1 for fwd or back
// centerline for all
int xC;
// modular ht dimens
int h = 110;
// offset of Y from h
int Dh = 0;
int speed, prevSpee;  // use MA of mouse speed

void setup()
{
size(400,600);
xC = width/2;
rectMode(CENTER);
}

void draw()
{
background(255);
fill(245);
stroke(255,100,100);
// shift Mr D with mouse speed, up=subtr Dh from rect Y; Dh cycles 0-10-0
if (dir==1) Dh = Dh+1;  //++ / -- doesnt work here
else Dh = Dh-1;
// println(dir + ": " + Dh);
if (Dh <= 0 || Dh >= end) dir = dir*(-1); // reverse at limits
rect(xC,20-Dh+1.6*h,0.5*h,h); // x,y,wid,ht
triangle(xC-0.3*h,20-Dh+1.1*h,xC,20-Dh+0.5*h,xC+0.3*h,20-Dh+1.1*h);// 3 x,y pts

// don't move the others

fill(255,120,120);  // curvy pinkish things
arc(xC,40+0.8*h,1.6*h,1.6*h,PI,3*PI/2, OPEN); // x,y,wid,ht,start,stop,style
arc(xC-0.8*h,40,1.6*h,1.6*h,0,PI/2, OPEN);
arc(xC,40+0.8*h,1.6*h,1.6*h,3*PI/2,2*PI, OPEN);
arc(xC+0.8*h,40,1.6*h,1.6*h,PI/2,PI, OPEN);

fill(220);
stroke(120,120,255);
ellipse(xC-0.3*h,20+2.1*h, 0.6*h,h); // same
ellipse(xC+0.3*h,20+2.1*h, 0.6*h,h);

fill(120,120,255); // bluish circles

ellipse(xC-0.3*h,30+2.2*h, 0.5*h,0.5*h);
ellipse(xC+0.3*h,30+2.2*h, 0.5*h,0.5*h);

// use MA of movement
int speed = (abs(mouseX-pmouseX) + abs(mouseY-pmouseY)+ 9*prevSpee);
int prevSpee = speed;
delay (100-min(85,9*speed)); // control frame redraw rate by decr delay w/ incr speed
//println(speed);
}
