/*
This is a simple demo script intended to allow users to quickly write blob detection

You'll have to finese for the gesture logic but overall this will get you started

You can port directly to serial with Processing's I/O and Serial libraries 
*/

/*
Import Processing Video Library and start a capture
*/
import processing.video.*;
Capture video;
color trackColor; 
ArrayList<Blob> blobs = new ArrayList<Blob>();

//Parameters, if these are smaller more accurate but you may need error
float colorThreshold = 25; //how close color needs to be
float distThreshold = 10; //distance threshold for if to catalog new Blobs 

//THIS RUNS ONCE
void setup() {
  size(640, 360);
  //If you have multiple cameras or webcam and you need to ID
  //String[] cameras = Capture.list();
  //printArray(cameras); 
  video = new Capture(this, 640, 360);
  video.start();
  trackColor = color(0, 255, 200);
  startTime = millis();
}

//THIS RUNS EACH LOOP 
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

//Capture video feed
void captureEvent(Capture video) {
  video.read();
}

//This just draws the parameter info
void drawInfo(){
  textAlign(RIGHT);
  fill(255);
  text("distance threshold: " + distThreshold, width-10, 25);
  text("color threshold: " + colorThreshold, width-10, 50);
  text("blobs found: " + blobs.size(), width - 10, 75);
}