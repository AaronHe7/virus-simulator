Simulation simulation = new Simulation();

void setup() {
  size(1800, 950);
  simulation.add(new House(100, 100, 400, 200));
  simulation.add(new House(500, 500, 300, 400));
  simulation.add(new House(50, 600, 150, 300));
  for (int i = 0; i < 20; i++) {
     simulation.addRandomPerson();
  }
  for (int i = 0; i < simulation.persons.size()/10; i++) {
     simulation.persons.get(i).infected = true;
  }
}

void draw() {
  background(255, 255, 255);
  simulation.update();
  simulation.display();
  textAlign(CENTER, TOP);
  fill(0);
  textSize(30);
  text("Virus Simulator", width/2, 20);
  textSize(20);
  text("Aaron He", width/2, 60);
  textAlign(RIGHT, TOP);
  text("Infected: " + simulation.numInfected(), width - 10, 20);
}
