
class Pvec
{    // make objects with (x,y) sets for loca and velo
    float x;  // x loc, dist from left margin
    float y;   // y loc  dist from top edge
    float xrate;
    float yrate;
    // construct from loca vars and default velo vars
    Pvec(float xloc,float yloc)
      {
      x = xloc;
      y = yloc;
      xrate = 1.5;
      yrate = 2.5;
      }
      // make add method for it to add to another vector
      void add(Pvec v) { y = this.y + v.y; x = this.x + v.x;}

}  // end class def
