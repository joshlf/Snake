// Copyright 2012 The Authors. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

int[] x = new int[1600];
int[] y = new int[1600];
int foodX, foodY;
int snakelength;
boolean kwp = false;
int xChange, yChange;
int addFoodLength;
//boolean wasReset = false;
boolean go = true;
int xblocks = (int(screen.width*0.9/5));
int yblocks = (int(screen.height*0.9/5));

//1 = up; 2 = right; 3 = down; 4 = left;
int direction;
int score = 1;

void setup() {
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
  kwp = false;
  background(0);

  //Check to see if ate food
  if (direction == 1) {
    xChange = 0;
    yChange = -5;
    if (abs(y[0] - 5 - foodY) < 5 && abs(x[0] - foodX) < 5) {
      setFood();
      score++;
      for (int j = 0; j < addFoodLength; j++) {
        snakelength++;
        x[snakelength] += x[snakelength - 2] - x[snakelength - 1];
        y[snakelength] += y[snakelength - 2] - y[snakelength - 1];
      }
    }
  }
  else if (direction == 2) {
    xChange = 5;
    yChange = 0;
    if (abs(y[0] - foodY) < 5 && abs(x[0] + 5 - foodX) < 5) {
      setFood();
      score++;
      for (int j = 0; j < addFoodLength; j++) {
        snakelength++;
        x[snakelength] += x[snakelength - 2] - x[snakelength - 1];
        y[snakelength] += y[snakelength - 2] - y[snakelength - 1];
      }
    }
  } 
  else if (direction == 3) {
    xChange = 0;
    yChange = 5;
    if (abs(y[0] + 5 - foodY) < 5 && abs(x[0] - foodX) < 5) {
      setFood();
      score++;
      for (int j = 0; j < addFoodLength; j++) {
        snakelength++;
        x[snakelength] += x[snakelength - 2] - x[snakelength - 1];
        y[snakelength] += y[snakelength - 2] - y[snakelength - 1];
      }
    }
  } 
  else if (direction == 4) {
    xChange = -5;
    yChange = 0;
    if (abs(y[0] - foodY) < 5 && abs(x[0] - 5 - foodX) < 5) {
      setFood();
      score++;
      for (int j = 0; j < addFoodLength; j++) {
        snakelength++;
        x[snakelength] += x[snakelength - 2] - x[snakelength - 1];
        y[snakelength] += y[snakelength - 2] - y[snakelength - 1];
      }
    }
  }

  //move each joint in snake to where the previous one is
  fill(255);
  if (snakelength != 1) {
    for(int i = snakelength - 1; i > 0; i-- ) {
      x[i] = x[i-1];
      y[i] = y[i-1];
      ellipse(x[i],y[i],5,5);
      if (x[i] == x[0] && y[i] == y[0] && i > 2)
        crash();
    }
  }
  x[0] += xChange;
  y[0] += yChange;

  //Crash into walls
  if (x[0] == 0 || x[0] == xblocks*5 || y[0] == 0 || y[0] == yblocks*5)
    crash();

  fill(255,0,0);
  ellipse(x[0],y[0],5,5);
  fill(0,255,0);
  ellipse(foodX,foodY,5,5);
  textSize(20);
  fill(0,255,0);
  text(score,10,30);


  if (!go)
    noLoop();
}

void keyPressed() {
  char w = 'w', d = 'd', s = 's', a = 'a';
  if (key == 32) {
    reset();
    //    if (wasReset)
    go = true;
    loop();
  }
  if (!kwp) {
    if (key == w && direction != 3)
      direction = 1;
    else if (key == d && direction != 4)
      direction = 2;
    else if (key == s && direction != 1)
      direction = 3;
    else if (key == a && direction != 2)
      direction = 4;
  }
  kwp = true;
}

void crash() {
  go = false;
  noLoop();
  //  wasReset = false;
}

void reset() {
  //  if (!wasReset) {
  score = 1;
  snakelength = 3;
  xChange = 0;
  yChange = 0;
  addFoodLength = int(width/100);
  direction = int(random(4));
  x[0] = int(random(80))*5;
  y[0] = int(random(80))*5;
  x[1] = x[0] - 5;
  y[1] = y[0];
  x[2] = x[1] - 5;
  y[2] = y[1];
  setFood();
  //  }
  //  wasReset = !wasReset;
}

void setFood() {
  foodX = int(random(xblocks))*5;
  foodY = int(random(yblocks))*5;
  if (foodX == 0 || foodX == xblocks*5 || foodY == 0 || foodY == yblocks*5)
    setFood();
}

