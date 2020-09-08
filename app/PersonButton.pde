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
    fill(255);
    circle(x + w/2, y + h/2, h/2);
    fill(0);
    circle(x + 5 * w/12, y + h/2, h/20);
    circle(x + 7 * w/12, y + h/2, h/20);
  }
  
  void registerClick(float x, float y) {
    boolean previouslyActive = active;
    super.registerClick(x, y);
    if (active && previouslyActive) {
      if (currentSimulation.nhouses < 1) {
        message.setMessage("There needs to be at least one house");
        return;
      }
      currentSimulation.add(new Person(x, y));
    }   
    if (active && !previouslyActive) {
      message.setMessage("Click to add a person");
      if (currentSimulation.nhouses < 1) {
        message.setMessage("There needs to be at least one house");
        active = false;
        return;
      }
    }
  }
}
