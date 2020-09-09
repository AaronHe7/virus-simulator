// Button for adding houses
class HouseButton extends Button {
  private boolean click1 = false, click2 = false;
  private float x1, y1, x2, y2;
  
  HouseButton(float x, float y, float w, float h) {
    super(x, y, w, h, "Add House");
  }
  
  HouseButton(float x, float y) {
    super(x, y, "Add House");
  }
  
  void display() {
    super.display();
    fill(255);
    strokeWeight(2);
    line(x + w/2, y + h/6, x + w/6, y + h/2);
    line(x + w/2, y + h/6, x + 5 * w/6, y + h/2);
    float rectOffset = 7;
    rect(x + w/6 + rectOffset, y + h/2 - rectOffset, 2 * (w/3 - rectOffset), 2 * (w/3 - rectOffset));
    if (click1) {
      circle(x1, y1, 10);
    }
  }
  
  void registerClick(float x, float y) {
    boolean previouslyActive = active;
    super.registerClick(x, y);
    if (previouslyActive && active) {
      if (!click1) {
        // Top left corner
        click1 = true;
        x1 = x;
        y1 = y;
      } else if (!click2) {
        // Bottom right corner
        x2 = x;
        y2 = y;
        click2 = true;
        House newHouse = new House(min(x1, x2), min(y1, y2), abs(x2 - x1), abs(y2 - y1));
        boolean overlaps = false;
        // Two houses cannot overlap
        for (House h : currentSimulation.houses) {
          if (h.overlaps(newHouse)) {
            overlaps = true;
          }
        }
        if (overlaps) {
          message.setMessage("Houses cannot overlap");
          active = false;
        } else if (min(abs(x1 - x2), abs(y1 - y2)) < 3 * Person.size) {
          message.setMessage("House is too small");
          active = false;
        } else {
          currentSimulation.add(newHouse);
        }
        click1 = click2 = false;
      }
    }
    if (active) {
      if (!click1) {
        assert(!click2);
        message.setMessage("Click the top-left point of the house");
      } else if (!click2) {
        assert(click1);
        message.setMessage("Click the bottom-right point of the house");
      }
    } else {
      click1 = click2 = false;
    }
  }
}
