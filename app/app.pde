ArrayList<Simulation> simulations = new ArrayList<Simulation>();
Simulation currentSimulation;
Message message = new Message(200, 30);
ArrayList<Clickable> buttons = new ArrayList<Clickable>();
ArrayList<TabButton> tabs = new ArrayList<TabButton>();
int ntabs = 8;

// Create default simulation
void setupDemo() {
  Simulation demo = simulations.get(0);
  demo.add(new House(300, 100, 400, 200));
  demo.add(new House(700, 500, 300, 400));
  demo.add(new House(250, 600, 150, 300));
  demo.add(new House(1100, 200, 340, 200));
  demo.add(new Road(demo.houses.get(0), demo.houses.get(1)));
  demo.add(new Road(demo.houses.get(1), demo.houses.get(3)));
  demo.add(new Road(demo.houses.get(1), demo.houses.get(2)));
  for (int i = 0; i < 20 * demo.houses.size(); i++) {
     demo.addRandomPerson();
  }
}

void setup() {
  frameRate(60);
  size(1900, 950);
  // Add a simulation for each tab
  for (int i = 0; i < ntabs; i++) {
    simulations.add(new Simulation());
    tabs.add(new TabButton(50, 450 + i * 60, 40, 40, i));
  }
  setupDemo();
  currentSimulation = simulations.get(0);
  currentSimulation.playButton.on = false;
  tabs.get(0).active = true;
  // Buttons that can customize a simulation
  buttons.add(new PersonButton(50, 100));
  buttons.add(new HouseButton(50, 225));
  buttons.add(new RoadButton(50, 350));
}

// Calls the draw function of the simulation, buttons, tabs, and messages.
void draw() {
  for (Simulation s : simulations) {
    s.update();
  }
  currentSimulation.display();
  for (Clickable button : buttons) {
    button.display();
  }
  for (Clickable tab : tabs) {
    tab.display();
  }
  message.display();
}

// Mouse interaction
void mousePressed() {
  for (Clickable b : buttons) {
    b.registerClick(mouseX, mouseY);
  }
  for (Clickable b : tabs) {
    b.registerClick(mouseX, mouseY);
  }
   currentSimulation.playButton.registerClick(mouseX, mouseY);
}

// De-activate all buttons
void resetButtons() {
  message.clear();
  for (Clickable b : buttons) {
    b.activate(false);
  }
  for (Clickable b : tabs) {
    b.activate(false);
  }
}

// Keyboard interaction
void keyPressed() {
  if (key >= '1' && key <= '8') {
    for (TabButton t : tabs) {
      t.active = t.index == (key - '1');
    }
    currentSimulation = simulations.get(key - '1');
  }
}
