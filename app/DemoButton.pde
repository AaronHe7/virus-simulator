class DemoButton implements Clickable {
  boolean active = false;
  float x, y, size = 20;
  private boolean demoing = false;
  private String caption = "Try Demo";
  
  DemoButton(float x, float y, float size) {
    this.x = x;
    this.y = y;
    this.size = size;
  }
  
  DemoButton(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  void display() {
    textSize(size);
    fill(0);
    if (contains(mouseX, mouseY)) {
      //line(0, 0, width, height);
      fill(50, 50, 50);
    }
    textAlign(LEFT, TOP);
    text(caption, x, y);
  }
  
  boolean contains(float x, float y) {
    return x > this.x && x < this.x + textWidth(caption) && y > this.y && y < this.y + size;
  }
  
  boolean active() {
    return active;
  }
  
  void activate(boolean active) {
    this.active = active;
  }
  
  void registerClick(float x, float y) {
    if (contains(x, y)) {
      demoing = !demoing;
      if (demoing) {
        caption = "Exit Demo";
        currentSimulation = demo;
      } else {
        caption = "Try Demo";
        currentSimulation = simulation;
      }
      resetButtons();
    }
  }
}
