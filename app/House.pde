class House {
  float x, y, w, h, centerX, centerY;
  int id;
  House(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    centerX = x + w/2;
    centerY = y + h/2;
  }
  void display() {
    fill(255, 255, 255);
    stroke(0);
    strokeWeight(2);
    rect(x, y, w, h); 
  }
  boolean inHouse(float x, float y) {
    return x > this.x && x < this.x + w && y > this.y && y < this.y + this.w;
  }
  boolean inHouse(float x, float y, float radius) {
    return x - radius > this.x && x + radius < this.x + w && y - radius > this.y && y + radius < this.y + this.h;
  }
}
