// Basic button class
class Button implements Clickable {
  boolean active = false;
  float x, y, w = 60, h = 60;
  private float textSize = 15;
  String caption;
  
  Button(float x, float y, float w, float h, String caption) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.caption = caption;
  }
  
  Button(float x, float y, String caption) {
    this.x = x;
    this.y = y;
    this.caption = caption;
  }
  
  private void fillBackground() {
    fill(245);
    strokeWeight(3);
    if (active) {
      fill(180);
    } else if (contains(mouseX, mouseY)) {
      fill(220);
    }
  }
  
  void display() {
    fillBackground();
    rect(x, y, w, h);
    textSize(textSize);
    fill(0);
    textAlign(CENTER, BOTTOM);
    text(caption, x + w/2, y - 10);
    fillBackground(); 
  }
  
  boolean contains(float x, float y) {
    return x > this.x && x < this.x + h && y > this.y && y < this.y + w;
  }
  
  boolean active() {
    return active;
  }
  
  void activate(boolean active) {
    this.active = active;
  }
  
  void registerClick(float x, float y) {
    if (contains(x, y)) {
      active = !active;
    } else {
      for (int i = 0; i < buttons.size(); i++) {
        if (buttons.get(i).contains(x, y)) {
          active = false;
        }
      }
    }
  }
}
