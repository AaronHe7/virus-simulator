// Button that adds people
class PersonButton extends Button {
  PersonButton(float x, float y, float w, float h) {
    super(x, y, w, h, "Add Person");
  }
  
  PersonButton(float x, float y) {
    super(x, y, "Add Person");
  }
  
  void display() {
    super.display();
    stroke(0);
    circle(x + w/2, y + h/2, h/2);
    circle(x + 5 * w/12, y + h/2, h/20);
    circle(x + 7 * w/12, y + h/2, h/20);
  }
  
  void registerClick(float x, float y) {
    boolean previouslyActive = active;
    super.registerClick(x, y);
    if (active && previouslyActive && !buttonClicked) {
      if (currentSimulation.nhouses < 1) {
        message.setMessage("There needs to be at least one house");
        return;
      }
      int amount = 1;
      boolean random = false;
      if (isShift) {
        amount = 10;
      }
      if (isCtrl) {
        random = true;
      }
      for (int i = 0; i < amount; i++) {
        if (random) {
          currentSimulation.addRandomPerson();
        } else {
          currentSimulation.add(new Person(x, y));
        }
      }
    }   
    if (active && !previouslyActive) {
      message.setMessage("Click to add a person.\nCtrl - Add randomly\nShift - Add 10 at a time.");
      if (currentSimulation.nhouses < 1) {
        message.setMessage("There needs to be at least one house");
        active = false;
        return;
      }
    }
  }
}
