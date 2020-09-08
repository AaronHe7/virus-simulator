class Slider {
  public float value, min, max, x, y, r = 50, w = 400, circle_x = 0;
  private float textSize = 20;
  public boolean clicked = true;
  Slider(float min, float max, float value, float x, float y) {
    assert(value >= min && value <= max && min < max);
    this.min = min;
    this.max = max;
    this.value = value;
    this.x = x;
    this.y = y;
    this.circle_x = x + w * (value - min)/(max - min);
  }
  void display() {
    fill(255); 
    stroke(0);
    strokeWeight(1);
    line(x, y, x + w, y);
    circle(circle_x, y, r);
    textSize(textSize);
    fill(0); 
    textAlign(CENTER, BOTTOM);
    text(value, x + w/2, y - r/2);
    text("Virus radius", x + w/2, y - r/2 - textSize - 10);
  }
  void registerClick(float x, float y) {
    if (Math.pow(y - this.y, 2) + Math.pow(x - circle_x, 2) <= r * r) {
      clicked = true;
    } else {
      clicked = false;
    }
    if (clicked) {
      this.value = Math.max(min, Math.min(max, min + (x - this.x)/w * (max - min)));
      this.circle_x = this.x + w * (value - min)/(max - min);
    }
  }
}
