// Adds a road
class RoadButton extends Button {
  private boolean click1 = false, click2 = false;
  House h1, h2;
  
  RoadButton(float x, float y, float w, float h) {
    super(x, y, w, h, "Add Road");
  }
  
  RoadButton(float x, float y) {
    super(x, y, "Add Road");
  }
  
  void display() {
    super.display();
    fill(255);
    strokeWeight(1);
    // Road icon
    line(x + 2 * w/3, y + h/6, x + w/6, y + 2 * h/3);
    line(x + 5 * w/6, y + h/3, x + w/3, y + 5 * h/6);
    for (int i = 0; i < 3; i++) {
      float j = i + 0.2;
      line(x + w/4 + 2 * j * w/12, y + 3 * h/4 - 2 * j * h/12, x + w/4 + (2 * j + 1) * w/12, y + 3 * h/4 - (2 * j + 1) * h/12);
    }
  }
  
  void registerClick(float x, float y) {
    boolean previouslyActive = active;
    super.registerClick(x, y);
    if (!active) {
      click1 = click2 = false;
    }
    if (previouslyActive && active && !buttonClicked) {
      if (!click1) {
        // First house
        boolean ok = false;
        // Checks whether or not the user clicked a house
        for (House h : currentSimulation.houses) {
          if (h.contains(x, y)) {
            h1 = h;
            ok = true;
            break;
          }
        }
        if (ok) {
          click1 = true;
        } else {
          message.setMessage("Please click a house");
          active = false;
          return;
        }
      } else {
        // Second house
        assert(!click2);
        boolean ok = false;
        for (House h : currentSimulation.houses) {
          if (h.contains(x, y) && h.id != h1.id) {
            h2 = h;
            ok = true;
            break;
          }
        }
        if (ok) {
          click2 = true;
        } else {
          message.setMessage("Please click a different house");
          active = false;
          return;
        }
      }
    }
    if (click1 && click2) {
      if (currentSimulation.isAdjacent(h1, h2)) {
        message.setMessage("Houses are already connected");
        active = false;
        return;
      } else {
        currentSimulation.add(new Road(h1, h2));
      }
      click1 = click2 = false;
    }
    if (active) {
      if (currentSimulation.nhouses < 2) {
        message.setMessage("There needs to be at least two houses");
        active = false;
      } else if (!click1) {
        assert(!click2);
        message.setMessage("Click the first house");
      } else {
        message.setMessage("Click the second house");
      }
    }
  }
}
