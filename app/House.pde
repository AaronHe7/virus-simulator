// Houses where all the people are assigned
class House {
  float x, y, w, h, centerX, centerY;
  int id;
  
  House(House h) {
    this(h.x, h.y, h.w, h.h);
  }
  
  House(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    centerX = x + w/2;
    centerY = y + h/2;
  }
  
  void display() {
    fill(255);
    stroke(0);
    strokeWeight(2);
    rect(x, y, w, h); 
  }
  
  boolean contains(float x, float y) {
    return x > this.x && x < this.x + w && y > this.y && y < this.y + h;
  }
  
  boolean contains(float x, float y, float radius) {
    return x - radius > this.x && x + radius < this.x + w && y - radius > this.y && y + radius < this.y + this.h;
  }
  
  boolean overlaps(House other) {
    if (y > other.y + other.h || y + h < other.y || x + w < other.x || x > other.x + other.w) {
      return false;
    }
    return true;
  }
}
