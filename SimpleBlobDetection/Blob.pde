//A simple blob class
class Blob {
  float minx;
  float miny;
  float maxx;
  float maxy;
  float x, y;

  ArrayList<PVector> points;

  Blob(float x, float y) {
    minx = x;
    miny = y;
    maxx = x;
    maxy = y;
    points = new ArrayList<PVector>();
    points.add(new PVector(x, y));
  }

  void show() {
    stroke(255, 255, 255);
    noFill();
    strokeWeight(2);
    rectMode(CORNERS);
    rect(minx, miny, maxx, maxy);
    fill(0);
    ellipse(center().x, center().y, 5, 5);
  }


  void add(float x, float y) {
    points.add(new PVector(x, y));
    minx = min(minx, x);
    miny = min(miny, y);
    maxx = max(maxx, x);
    maxy = max(maxy, y);
  }
  
  PVector center(){
    return new PVector(minx + ((maxx-minx)/2), miny + ((maxy-miny)/2));
  }

  float size() {
    return (maxx-minx)*(maxy-miny);
  }

  boolean isNear(float x, float y) {
    // Closest point in blob strategy
    float d = 10000000;
    for (PVector v : points) {
      float tempD = distSq(x, y, v.x, v.y);
      if (tempD < d) {
        d = tempD;
      }
    }

    if (d < distThreshold*distThreshold) {
      return true;
    } else {
      return false;
    }
  }
}