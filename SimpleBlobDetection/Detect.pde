int pixelInterval = 2; //number of pixels to skip, less accurate with increase, but more speed

int startTime;
boolean isTimed = false;

void detectBlobs(){  
   if(isTimed){
   int curTime = millis() - startTime;
   if (curTime > timer){
     blobs.clear();
     startTime = millis();
     println("CLEARED");
   }
   }
   else blobs.clear();
   
  // Begin loop to walk through pixels based on interval for speed
  for (int x = 0; x < video.width; x+=pixelInterval ) {
    for (int y = 0; y < video.height; y+=pixelInterval ) {
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

      if (d < colorThreshold*colorThreshold) {

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
}