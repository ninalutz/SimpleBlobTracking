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
float colorThreshold = 25;
float distThreshold = 10;

ArrayList<Blob> blobs = new ArrayList<Blob>();

void setup() {
  size(640, 360);
  //If you have multiple cameras or webcam and you need to ID
  //String[] cameras = Capture.list();
  //printArray(cameras); 
  video = new Capture(this, 640, 360);
  video.start();
  trackColor = color(255, 255, 255);
  startTime = millis();
}

void captureEvent(Capture video) {
  video.read();
}

void draw() {
  //Draws video and parameters
  video.loadPixels();
  image(video, 0, 0);
  drawInfo();
  
  //detects Blobs
  detectBlobs();

  for (Blob b : blobs) {
      b.show();
  }
  
}

//This just draws the parameter info
void drawInfo(){
  textAlign(RIGHT);
  fill(255);
  text("distance threshold: " + distThreshold, width-10, 25);
  text("color threshold: " + colorThreshold, width-10, 50);
  text("blobs found: " + blobs.size(), width - 10, 75);
}