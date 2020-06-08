class Road {
  House h1, h2;
  Road(House a, House b) {
    h1 = a;
    h2 = b;
  }
  void display() {
    strokeWeight(20);
    stroke(0);
    line(h1.centerX, h1.centerY, h2.centerX, h2.centerY);
  }
}
