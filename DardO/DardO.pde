size(200,360);
// centerline for all
float xC = width/2;
// modular ht dimens
float h = 110;
rectMode(CENTER);
rect(xC,20+1.6*h,0.5*h,h); // x,y,wid,ht
ellipse(xC-0.3*h,20+2.1*h, 0.6*h,h); // same
ellipse(xC+0.3*h,20+2.1*h, 0.6*h,h);
triangle(xC-0.3*h,20+1.1*h,xC,20+0.5*h,xC+0.3*h,20+1.1*h);// 3 pts
//noFill();
fill(255,120,120);
noStroke();
arc(xC,40+0.8*h,1.6*h,1.6*h,PI,3*PI/2, OPEN); // x,y,wid,ht,start,stop,style
arc(xC-0.8*h,40,1.6*h,1.6*h,0,PI/2, OPEN);
arc(xC,40+0.8*h,1.6*h,1.6*h,3*PI/2,2*PI, OPEN);
arc(xC+0.8*h,40,1.6*h,1.6*h,PI/2,PI, OPEN);
fill(120,120,255);
noStroke();
ellipse(xC-0.3*h,30+2.2*h, 0.5*h,0.5*h);
ellipse(xC+0.3*h,30+2.2*h, 0.5*h,0.5*h);
