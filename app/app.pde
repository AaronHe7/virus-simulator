Simulation simulation = new Simulation();

void setup() {
  size(1800, 950);
  simulation.add(new House(300, 100, 400, 200));
  simulation.add(new House(700, 500, 300, 400));
  simulation.add(new House(250, 600, 150, 300));
  simulation.add(new House(1100, 200, 400, 200));
  simulation.add(new Road(simulation.houses.get(0), simulation.houses.get(1)));
  simulation.add(new Road(simulation.houses.get(1), simulation.houses.get(3)));
  for (int i = 0; i < 20 * simulation.houses.size(); i++) {
     simulation.addRandomPerson();
  }
  //for (int i = 0; i < simulation.houses.size(); i++) {
  //   simulation.setInfected(i);
  //}
  simulation.setInfected(0);
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
  text("Infected: " + simulation.ninfected, width - 10, 20);
  text("Dead: " + simulation.ndead, width - 10, 50);
}
