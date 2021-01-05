// Road that connects two houses
class Road {
  House h1, h2;
  Road(House a, House b) {
    h1 = a;
    h2 = b;
  }
  void display() {
    strokeWeight(40);
    stroke(64);
    line(h1.centerX, h1.centerY, h2.centerX, h2.centerY);
  }
}
