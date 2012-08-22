// Copyright 2012 The Authors. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

ASnake[] snakes = new ASnake[2];
int foodX, foodY;
//int snakelength;
boolean kwp = false;
int xChange, yChange;
int addFoodLength;
boolean go = true;
int xblocks = (int(screen.width*0.9/5));
int yblocks = (int(screen.height*0.9/5));

int score = 1;

void setup() {
  snakes[0] = new ASnake('w', 's', 'a', 'd', color(0, 255, 0));
  snakes[1] = new ASnake('i', 'k', 'j', 'l', color(0, 0, 255));
  
  print(xblocks + " ");
  println(yblocks);
  size(int(screen.width*0.9),int(screen.height*0.9));
  fill(255,0,0);
  background(0);
  noStroke();
  reset();
  frameRate((screen.width/500)*15);
}

void draw() {
  background(0);
  
  for (int i = 0; i < snakes.length; i++) {
    ASnake s = snakes[i];
    s.keyPressedThisTurn = false;
    
    if (s.direction == 1) {
      s.xChange = 0;
      s.yChange = -5;
    } else if (s.direction == 2) {
      s.xChange = 5;
      s.yChange = 0;
    } else if (s.direction == 3) {
      s.xChange = 0;
      s.yChange = 5;
    } else {
      s.xChange = -5;
      s.yChange = 0;
    }
    
    // Check to see if ate food
    
    if (abs(s.y[0] + s.yChange - foodY) < 5 && abs(s.x[0] + s.xChange - foodX) < 5) {
      setFood();
      s.score++;
      for (int j = 0; j < addFoodLength; j++) {
          s.len++;
          s.x[s.len] += s.x[s.len - 2] - s.x[s.len - 1];
          s.y[s.len] += s.y[s.len - 2] - s.y[s.len - 1];
      }
    }    
    
    // move each joint to where the previous one is
    fill(s.c);
    if (s.len != 1) {
      for (int j = s.len - 1; j > 0; j--) {
        s.x[j] = s.x[j - 1];
        s.y[j] = s.y[j - 1];
        ellipse(s.x[j], s.y[j], 5, 5);
        if (s.x[j] == s.x[0] && s.y[j] == s.y[0] && j > 2)
          crash();
      }
    }
    
    s.x[0] += s.xChange;
    s.y[0] += s.yChange;
    
    // Crash into walls
    if (s.x[0] <= 0 || s.x[0] >= xblocks*5 || s.y[0] <= 0 || s.y[0] >= yblocks*5)
      crash();
    fill(255,0,0);
    ellipse(s.x[0],s.y[0],5,5);
    
    // Draw score
    textSize(20);
    fill(s.c);
    text(s.score, 10 + 50 * i, 30);
  }
  
  // Draw food
  fill(0,255,0);
  ellipse(foodX,foodY,5,5);
//  textSize(20);
//  fill(0,255,0);
//  text(score,10,30);

  if (!go)
    noLoop();
}

void keyPressed() {
  if (key == 32) {
      reset();
      go = true;
      loop();
  }
  for (int i = 0; i < snakes.length; i++) {
    ASnake s = snakes[i];
    if (!s.keyPressedThisTurn) {
      if (key == s.up && s.direction != 3)
        s.direction = 1;
      else if (key == s.right && s.direction != 4)
        s.direction = 2;
      else if (key == s.down && s.direction != 1)
        s.direction = 3;
      else if (key == s.left && s.direction != 2)
        s.direction = 4;
    }
  }
}

void crash() {
  go = false;
  noLoop();
}

void reset() {
  score = 1;
  
  for (int i = 0; i < snakes.length; i++) {
    ASnake s = snakes[i];
    s.len = 3;
    s.xChange = 0;
    s.yChange = 0;
    s.direction = int(random(4));
    s.x[0] = int(random(80)) * 5;
    s.y[0] = int(random(80)) * 5;
    s.x[1] = s.x[0] - s.xChange;
    s.y[1] = s.y[0] - s.yChange;
    s.x[2] = s.x[1] - s.xChange;
    s.y[2] = s.y[2] - s.yChange;
  }
  
  addFoodLength = int(width/100);
  setFood();
}

void setFood() {
  foodX = int(random(xblocks))*5;
  foodY = int(random(yblocks))*5;
  if (foodX == 0 || foodX == xblocks*5 || foodY == 0 || foodY == yblocks*5)
    setFood();
}

