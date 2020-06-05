class House {
  float x, y, w, h;
  House(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  void display() {
    fill(255, 255, 255);
    stroke(0);
    strokeWeight(2);
    rect(x, y, w, h); 
  }
}
