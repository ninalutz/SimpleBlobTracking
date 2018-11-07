/*
This is a simple demo script intended to allow users to quickly write blob detection
Based off coding train example
*/

/*
Import Processing Video Library and start a capture
*/
import processing.video.*;
Capture video;

//Parameters 
color trackColor; 
float threshold = 25;
float distThreshold = 50;

ArrayList<Blob> blobs = new ArrayList<Blob>();

void setup() {
  size(640, 360);
  String[] cameras = Capture.list();
  printArray(cameras);
  video = new Capture(this, 640, 360);
  video.start();
  trackColor = color(150, 100, 150);
}

void captureEvent(Capture video) {
  video.read();
}

void keyPressed() {
  if (keyCode == UP) {
    distThreshold+=5;
  } else if (keyCode == DOWN) {
    distThreshold-=5;
  }
  if (keyCode == RIGHT) {
    threshold+=5;
  } else if (keyCode == LEFT) {
    threshold-=5;
  }


  println(distThreshold);
}

void draw() {
  video.loadPixels();
  image(video, 0, 0);

  blobs.clear();


  // Begin loop to walk through every pixel
  for (int x = 0; x < video.width; x++ ) {
    for (int y = 0; y < video.height; y++ ) {
      int loc = x + y * video.width;
      // What is current color
      color currentColor = video.pixels[loc];
      float r1 = red(currentColor);
      float g1 = green(currentColor);
      float b1 = blue(currentColor);
      float r2 = red(trackColor);
      float g2 = green(trackColor);
      float b2 = blue(trackColor);

      float d = distSq(r1, g1, b1, r2, g2, b2); 

      if (d < threshold*threshold) {

        boolean found = false;
        for (Blob b : blobs) {
          if (b.isNear(x, y)) {
            b.add(x, y);
            found = true;
            break;
          }
        }

        if (!found) {
          Blob b = new Blob(x, y);
          blobs.add(b);
        }
      }
    }
  }

  for (Blob b : blobs) {
    if (b.size() > 500) {
      b.show();
    }
  }

  textAlign(RIGHT);
  fill(0);
  text("distance threshold: " + distThreshold, width-10, 25);
  text("color threshold: " + threshold, width-10, 50);
}