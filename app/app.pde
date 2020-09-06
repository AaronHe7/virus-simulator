ArrayList<Simulation> simulations = new ArrayList<Simulation>();
Simulation currentSimulation;
Message message = new Message(200, 30);
ArrayList<Clickable> buttons = new ArrayList<Clickable>();
int tabs = 8;

void setupDemo() {
  Simulation demo = simulations.get(0);
  demo.add(new House(300, 100, 400, 200));
  demo.add(new House(700, 500, 300, 400));
  demo.add(new House(250, 600, 150, 300));
  demo.add(new House(1100, 200, 400, 200));
  demo.add(new Road(demo.houses.get(0), demo.houses.get(1)));
  demo.add(new Road(demo.houses.get(1), demo.houses.get(3)));
  demo.add(new Road(demo.houses.get(1), demo.houses.get(2)));
  for (int i = 0; i < 20 * demo.houses.size(); i++) {
     demo.addRandomPerson();
  }
}

void setup() {
  size(1800, 950);
  for (int i = 0; i < tabs; i++) {
    simulations.add(new Simulation());
    buttons.add(new TabButton(50, 400 + i * 100, i));
  }
  setupDemo();
  currentSimulation = simulations.get(0);
  buttons.add(new PersonButton(50, 100));
  buttons.add(new HouseButton(50, 225));
  buttons.add(new RoadButton(50, 350));
}

void draw() {
  currentSimulation.update();
  currentSimulation.display();
  for (Clickable button : buttons) {
    button.display();
  }
  message.display();
}

void mousePressed() {
  for (int i = 0; i < buttons.size(); i++) {
    Clickable button = buttons.get(i);
    button.registerClick(mouseX, mouseY);
  }
}

void resetButtons() {
  message.clear();
  for (Clickable b : buttons) {
    b.activate(false);
  }
}