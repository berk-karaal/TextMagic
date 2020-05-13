public class Dot {
  float posX, posY; // Dot should be at that coordinates
  float yN, xN; // Dot's current coordinates
  float xSpeed, ySpeed; // Speed of Dot
  float roadX, roadY; // Distance between Dot's start position and destination (X and Y are separate)

  color clr; // Color of this Dot
  
  // Current distance to destination (X and Y separate)
  float yDis;
  float xDis;
  
  public Dot(float x_, float y_, color clr_, float xN_, float yN_) {
    posX=x_;
    posY=y_;
    clr=clr_;
    xN = xN_;
    yN = yN_;
    roadX = Math.abs(xN-posX);
    roadY = Math.abs(yN-posY);
  }

  void draw() {
    yDis=Math.abs(yN-posY);
    xDis=Math.abs(xN-posX);
    
    calc(); // Calculate the speeds of Dot
    
    if (!(xN > posX-xSpeed && xN < posX+xSpeed)) {
       // If the Dot is NOT close enough to the position it should be (Calculated speed)
      xN+=xSpeed*(xN<posX?1:-1); // If the target is to the right, give positive speed. (Else negative)
    }else{
      // If the point is close enough to the position it should be (Assign too low speed to take the nearest position)
      xN+=(xN<posX-0.6f?0.5f:(xN>posX+0.6f?-0.5f:0));
    }
    
    if (!(yN > posY-ySpeed && yN < posY+ySpeed)) {
      // If the Dot is NOT close enough to the position it should be (Calculated speed)
      yN+=ySpeed*(yN<posY?1:-1); // If the target is to the right, give positive speed. (Else negative)
    }else{
      // If the point is close enough to the position it should be (Assign too low speed to take the nearest position)
      yN+=(yN<posY-0.6f?0.5f:(yN>posY+0.6f?-0.5f:0));
    }

    // Draw the Dot
    noStroke();
    fill(clr);
    ellipse(xN, yN, objRadius, objRadius);
    
  }

  void calc() {
    // My speed calculations
    if (xDis<yDis) {
      ySpeed = objSpeed*((yDis+objSpeed*(10.0f-slowingRate))/roadY);
      xSpeed = xDis/(yDis/ySpeed);
    } else {
      xSpeed = objSpeed*((xDis+objSpeed*(10.0f-slowingRate))/roadX);
      ySpeed = yDis/(xDis/xSpeed);
    }
  }
}
