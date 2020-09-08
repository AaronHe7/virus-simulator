class TabButton extends Button {
  private int index;
  House h1, h2;
  
  TabButton(float x, float y, float w, float h, int index) {
    super(x, y, w, h, Integer.toString(index + 1));
    this.index = index;
  }
  
  TabButton(float x, float y, int index) {
    super(x, y, Integer.toString(index + 1));
    this.index = index;
  }
  
  void display() {
    fill(255);
    strokeWeight(3);
    if (active) {
      stroke(0, 0, 220);
    } else if (contains(mouseX, mouseY)) {
      stroke(50, 50, 50);
    } else {
      stroke(0);
    }
    rect(x, y, w, h);
    textSize(super.textSize);
    fill(0);
    textAlign(CENTER, CENTER);
    text(caption, x + w/2, y + h/2);
  }
  
  void registerClick(float x, float y) {
    if (contains(x, y)) {
      currentSimulation = simulations.get(index);
      active = true;
    } else {
      for (int i = 0; i < tabs.size(); i++) {
        if (tabs.get(i).contains(x, y)) {
          active = false;
        }
      }
    }
  }
}
