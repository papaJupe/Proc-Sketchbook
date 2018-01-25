/*
Learn Proc ed. 2 example 18-3 of bubble creation from file, writing back to file
Uses: loadData from .csv file, put in table, make new obj on mouse click, show text
on rollover (which I had to rewrite as bool())


*/


Table table; 
Bubble[] bubbles;

void setup() 
{ 
    size(480, 360);
    loadData();
}  // end setup

void draw() 
    { 
    background(255); 
    for (int i = 0; i < bubbles.length; i++) // Display all bubbles 
        bubbles[i].display();
        // could also put rollover check here, using orig fx()
        // bubbles[i].rollover(mouseX, mouseY);
    }  // end draw


void loadData() 
{ 
table = loadTable("bubba.csv", "header"); 
//Make a Bubble object out of the data from each row
bubbles = new Bubble[table.getRowCount()];
for (int i = 0; i < table.getRowCount(); i++) 
  {
    TableRow row = table.getRow(i);
    
    float x = row.getFloat("x"); 
    float y = row.getFloat("y"); 
    int d = row.getInt("diam"); 
    String n = row.getString("name"); 
    bubbles[i] = new Bubble(x, y, d, n);
  }  // end for
}  // end loadData

void mousePressed() 
{ // create a new row and set the values for each row/col
    TableRow row = table.addRow(); 
    row.setFloat("x", mouseX); 
    row.setFloat("y", mouseY); 
    row.setInt("diam", (int)random(40, 80)); 
    row.setString("name", "newBlah");
       //If the table has more than 10 rows, delete the oldest row.
    if (table.getRowCount() > 10) 
        table.removeRow(0);
      //This writes the table back to the original CSV file and reloads it
    saveTable(table, "data/bubba.csv"); 
    loadData();
}  // end mousepress

class Bubble 
{ 
float x, y; 
float diameter; 
String name;
boolean over = false;
// construct the Bubble 
Bubble(float tempX, float tempY, float tempD, String s) 
  {
  x = tempX; y = tempY; diameter = tempD; name = s;
  }  // end construct

// Checking if mouse is over the bubble 
// void rollover(float px, float py)  // what calls this fx(), nothing originally
 boolean rollover()  // returns a bool
 {
      float d = dist(mouseX, mouseY, x, y); 
      if (d < diameter/2) 
         return true; 
      else
        return false;
  }  // end rollover

// Display the Bubble and caption on mouse-over
void display() 
  {
  stroke(0); strokeWeight(2); noFill(); ellipse(x, y, diameter, diameter);
 
 // need to track mouseX,Y w/ rollover() to see if it's inside this obj
 
  //if (over) // orig. rollover made over T/F, but no rollover fx call anywhere
  if (rollover())
    {
      fill(0); textAlign(CENTER);
      text(name, x, y+diameter/2+20);
     }  // end if
  } // end display

} // end class
