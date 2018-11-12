// Custom distance functions w/ no square root for optimization
float distSq(float x1, float y1, float x2, float y2) {
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1);
  return d;
}

float distSq(float x1, float y1, float z1, float x2, float y2, float z2) {
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) +(z2-z1)*(z2-z1);
  return d;
}


//IO Methods 
void mousePressed() {
  // Save color where the mouse is clicked in trackColor variable
  int loc = mouseX + mouseY*video.width;
  trackColor = video.pixels[loc];
}


void keyPressed() {
  if (keyCode == UP) {
    distThreshold+=5;
  } else if (keyCode == DOWN) {
    distThreshold-=5;
  }
  if (keyCode == RIGHT) {
    colorThreshold+=5;
  } else if (keyCode == LEFT) {
    colorThreshold-=5;
  }
}