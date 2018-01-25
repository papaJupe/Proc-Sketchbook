/**
 * Letters mod example to show AWT font, which won't actually 
  display in PApplet
 * 
 * Draws all letters to the screen. This requires loading a font, 
 * setting the font, and then drawing the letters. If you 
 enlarge window, it shows all, up above ascii range, noLoop
 draws once
 */
import java.awt.Font;
Font f;

void setup() {
  size(800, 600);
  background(0); 

  // Create the font OK but PApplet can't use as is
  f = new Font("Arial", Font.PLAIN, 30);
  setFont(f);
  
  textAlign(CENTER, CENTER);
} 

void draw() {
  background(0);

  // Set the left and top margin
  int margin = 10;
  translate(margin*4, margin*4);

  int gap = 46;
  int counter = 35;

  for (int y = 0; y < height-gap; y += gap) {
    for (int x = 0; x < width-gap; x += gap) {

      char letter = char(counter);

      if (letter == 'A' || letter == 'E' || letter == 'I' || letter == 'O' || letter == 'U') {
        fill(255, 204, 0);
      } else {
        fill(255);
      }

      // Draw the letter to the screen
      // textFont(f); AWT font fails this method in PApplet; can change PFont 
      // size w/ this
      textSize(16);
      text(letter, x, y);

      // Increment the counter
      counter++;
      noLoop();  // so it draws once instead of infinitely
    }
  }
}

