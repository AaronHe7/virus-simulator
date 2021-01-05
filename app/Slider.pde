// Sliders that can control certain factors (e.g. radius of transmission)
class Slider {
  public float value, min, max, x, y, r = 25, w = 350, circle_x = 0;
  private String caption;
  private float textSize = 20;
  public boolean clicked = true;
  Slider(float min, float max, float value, float x, float y, String caption) {
    assert(value >= min && value <= max && min < max);
    this.min = min;
    this.max = max;
    this.value = value;
    this.x = x;
    this.y = y;
    this.caption = caption;
    this.circle_x = x + w * (value - min)/(max - min);
  }
  void display() {
    fill(0); 
    stroke(0);
    strokeWeight(1);
    line(x, y, x + w, y);
    circle(circle_x, y, 2 * r);
    textSize(textSize);
    fill(0); 
    textAlign(CENTER, BOTTOM);
    text(value, x + w/2, y - r/2);
    // Text to indicate what variable the slider controls
    text(caption, x + w/2, y - r/2 - textSize - 10);
  }
  void registerClick(float x, float y) {
    if (clicked) {
      // Set value based on mouse coordinate of mouse
      this.value = Math.max(min, Math.min(max, min + (x - this.x)/w * (max - min)));
      this.circle_x = this.x + w * (value - min)/(max - min);
    }
  }
  boolean contains(float x, float y) {
    return Math.pow(y - this.y, 2) + Math.pow(x - circle_x, 2) <= r * r;
  } 
}
