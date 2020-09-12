// Button that allows you to pause a simulation to give you more time to adjust the simulation
class PlayButton extends Button {
  public boolean on = true;
  PlayButton(float x, float y) {
    super(x, y, "");
  }
  void display() {
    super.display();
    fill(0);
    if (on) {
      triangle(x + w/4, y + h/4, x + w/4, y + 3 * h/4, x + 3 * w/4, y + h/2);
    } else {
      rect(x + w/6, y + h/4, w/4, h/2);
      rect(x + w - w/6 - w/4, y + h/4, w/4, h/2);
    }
  }
  void registerClick(float x, float y) {
    if (contains(x, y)) {
      on = !on;
    }
  }
}
