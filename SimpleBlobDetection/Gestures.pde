//Some categorized gestures 
int timer = 4100; //number of milliseconds for gesture logic
int clickTimer = 2000;
int holdTimer = 4000;

int numHoldBlobs = 1; //may want to make this higher or lower depending on calibration
int numClickBlobs = 2;
int locationThreshold = 10; //pixels that center can differ from to still be considered same blob

//Click gesture boolean
boolean isClickGesture(){
  //See if in range for click blobs and at appropriate timer 
  int curTime = millis() - startTime;
  if(curTime > clickTimer && blobs.size() <= numClickBlobs && blobs.size() >0){
    return true;
  }
  return false;
}

//Hold gesture boolean
boolean isHoldGesture(){
  //See if in range for hold blobs and at appropriate timer 
  int curTime = millis() - startTime;
  if(curTime > holdTimer && blobs.size() <= numHoldBlobs && blobs.size() >0){
    return true;
  }
  return false;
}