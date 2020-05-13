/*
 MAGICAL TEXT
 
 Goal: The dots are formed in a random position and they all come together to make the given text visible.
 
 Created by BERK KARAAL
 6 May 2020
 */
final int S_CENTER=0, S_LEFT=1, S_RIGHT=2, S_TOP=3, S_BOTTOM=4, S_RANDOM=5;

///////////////////////// CHANGE THESE /////////////////////////////////////////////
String ytext = "HELLO";  // Your text

int startX = S_RANDOM;
int startY = S_RANDOM;
/* 
 startX - startY options:
 S_RANDOM (can be use for both) -> All Dots start from random positions
 S_CENTER (can be use for both) -> All Dots start from the middle of the assigned axis
 S_LEFT (only for startX) -> All Dots start from left side
 S_RIGHT (only for starX) -> All Dots start from right side
 S_TOP (only for startY) -> All Dots start from top of screen
 S_BOTTOM (only for startY) -> All Dots start from bottom of screen
 */

float objDistance = 15.0f;  // Distance between 2 dots (You can think like opposite density) (default: 15)
float objRadius = 10f;  // Radius of dots (default: 10)
float objSpeed = 10.0f;  // Start speed of dots  (default: 10) (high speed is not recommended)
float slowingRate = 0.0f; // (MAX 10) higher rate means slower finish speed (CAN BE NEGATIVE for fast movements)
////////////////////////////////////////////////////////////////////////////////////

import java.util.ArrayList;
PFont font;
ArrayList<Dot> dot = new ArrayList<Dot>(); // All Dot objects will be stored in t"his
int objCount=0; // You can see how many objects (dots) created for your text

void setup() {
  fullScreen();

  // Creating dots (Go to the end of code to read what I did here)
  background(255); // white background
  font = createFont("Catamaran-Black.ttf", 1); // Get the font to program
  textFont(font);
  textAlign(CENTER, CENTER);
  fill(0); // black text color
  int tSize = 600;
  textSize(tSize);
  while (textWidth(ytext)>width-100) {
    tSize -=10;
    textSize(tSize);
  }
  text(ytext, width/2, height/2-tSize/4); // draw text on screen
  PImage screen = get(); // Now, I saved frame to check pixel colors

  background(0); // Cleared screen

  int startX_=0, startY_=0;
  switch(startX) {
  case 0:
    startX_=width/2;
    break;
  case 1:
    startX_=0;
    break;
  case 2:
    startX_=width;
    break;
  }
  switch(startY) {
  case 0:
    startY_=height/2;
    break;
  case 3:
    startY_=0;
    break;
  case 4:
    startY_=height;
    break;
  }

  for (int x=0; x<width; x+=objDistance) {
    for (int y=0; y<height; y+=objDistance) {
      if (screen.get(x, y) == color(0)) {
        objCount++;
        color c = color(random(255), random(255), random(255)); // create random color
        while (brightness(c)<100) { // created color shouldn't be dark
          c = color(random(255), random(255), random(255)); // change it while it is brighter
        }
        dot.add(new Dot(x, y, c, startX==S_RANDOM?random(width):startX_, startY==S_RANDOM?random(height):startY_)); // Create a new Dot object and add it to ArrayList
      }
    }
  }
  println("Created object count: "+objCount); // Print how many dots created
  // Dots created
}

void draw() {
  background(0); // For black background
  for (int i=0; i<dot.size(); i++) { // Calling all Dot's draw method in every frame
    dot.get(i).draw();
  }
}


/*
 What I did in "Creating dots"? 
 
 My idea was, drawing text to screen and checking all pixels for finding all pixels which has same color with text. (Of course I jumped few pixels to finish it faster)
 So I filled background with white and filled text with black. Then I checked pixels for which are black. After that I created a Dot to where I found a black pixel.
 That's why there is a white screen at the start and you are waiting (until program finishes it's checks).
 */
