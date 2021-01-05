// A simulation contains all roads, houses, and people. Each simulation is independant.
class Simulation {
  ArrayList<House> houses = new ArrayList<House>();
  ArrayList<Person> persons = new ArrayList<Person>();
  ArrayList<Road> roads = new ArrayList<Road>();
  ArrayList<Slider> sliders = new ArrayList<Slider>();
  ArrayList<ArrayList<Integer>> adjacent = new ArrayList<ArrayList<Integer>>();
  PlayButton playButton = new PlayButton(width - 70, 120);
  private int npersons = 0, ninfected = 0, ndead = 0, ncases = 0, nhouses;
  private boolean paused = true;
  private float totalArea = 0;
  private float virusR = 20, virusP = 0.01, healP = 0.0003, deathP = 0.00015, moveP = 0.0005;
  public int id;
  Graph graph = new Graph(width - 360, 350, 300, 300);
  
  Simulation() {
    sliders.add(new Slider(1, 80, virusR, width - 380, 900, "Virus radius"));
    sliders.add(new Slider(0, 0.2, moveP * 100, width - 380, 800, "Travel rate"));
    graph.addLine(255, 0, 0);
    graph.addLine(255, 255, 0);
    graph.addLine(0, 0, 255);
  }
  
  // Copy constructor
  Simulation(Simulation s) {
    this();
    for (House h : s.houses) {
      add(new House(h));
    }
    for (Person p : s.persons) {
      add(new Person(p, houses.get(p.house.id)));
    }
    for (Road r : s.roads) {
      add(new Road(houses.get(r.h1.id), houses.get(r.h2.id)));
    }
    ninfected = s.ninfected;
    ndead = s.ndead;
    ncases = s.ncases;
    graph = new Graph(s.graph);
  }
  
  void updateSliders() {
    for (Slider s : sliders) {
      // When slider is initially clicked, it is "active" and can be dragged until mouse is released
      if (!s.clicked) {
        s.clicked = mousePressed && s.contains(mouseX, mouseY);
      }
      s.clicked &= mousePressed;
      s.registerClick(mouseX, mouseY);
    }
    this.virusR = sliders.get(0).value;
    this.moveP = sliders.get(1).value/100;
  }
  
  // Infect people too close, people randomly heal/die
  void updatePeople() {
    for (Person person : persons) {
      if (random(0, 1) < moveP && !person.onRoad) { // switch houses at random
         House newhouse = randomHouse();
         if (isAdjacent(newhouse, person.house)) {
            person.house = newhouse;
            break;
         }
      }
      person.update();
    }
    for (int i = 0; i < persons.size(); i++) {
      Person p1 = persons.get(i);
      if (!p1.infected) {
        boolean inContact = false;
        for (Person p2 : persons) {
          if (p2.infected && dist(p1.x, p1.y, p2.x, p2.y) < virusR) {
            inContact = true;
            break;
          }
        }
        // If the person is close to another person, they have a chance of being infected
        if (inContact && random(0, 1) < virusP) {
          p1.infected = true;
          ninfected++;
          ncases++;
        }
      } else if (!p1.patientZero || (ninfected + ndead >= (npersons + ndead)/3 && npersons >= 5)) {
        // A person will have a chance of being healed, or die if they are not the patient zero, or if enough people are infected
        if (random(0, 1) < healP) {
          p1.patientZero = false;
          ninfected--;
          p1.infected = false;
        } else if (random(0, 1) < deathP) {
          p1.patientZero = false;
          ndead++;
          ninfected--;
          npersons--;
          persons.remove(i);
        }
      }
    }
  }
  
  void updateGraph() {
    if (ninfected > 0 && npersons > 0) {
      graph.update();
      if (graph.time % graph.updateFrequency == 0) {
        graph.addEntry(0, ncases);
        graph.addEntry(1, ninfected);
        graph.addEntry(2, ndead);
      }
    }
  }
  
  void update() {
    paused = !playButton.on;
    if (paused) {
      return;
    }
    updatePeople();
    updateGraph();
  }
  
  void display() {
    // White
    background(255, 255, 255);
    // Green
    background(86, 232, 86);
    for (Road r : roads) {
      r.display();
    }
    for (House h : houses) { 
      h.display();
    }
    for (Person p : persons) {
      p.display();
    }
    graph.display();
    for (Slider s : sliders) {
      s.display();
    }
    playButton.display();
    // Title, statistics, and credits
    textAlign(CENTER, TOP);
    fill(0);
    textSize(30);
    text("Virus Simulator", width/2, 20);
    textSize(20);
    text("Aaron He", width/2, 60);
    textAlign(RIGHT, TOP);
    // Total number of infections
    text("Cases: " + ncases, width - 10, 20);
    // Number of people who are currently infected
    text("Infected: " + ninfected, width - 10, 50);
    // Number of dead people
    text("Dead: " + ndead, width - 10, 80);
    // Number of alive people
    text("Alive: " + npersons, width - 10, 200);
  }
  
  void addRandomPerson() {  
    float prefix = 0; // Make people in house proportional to area
    float rand = random(0, totalArea);
    for (House h : houses) {
       float area = h.h * h.w;
       if (rand >= prefix && rand < prefix + area) {
         add(new Person(h));
         break;
       }
       prefix += area;
    }
    assert(persons.size() == npersons);
  }
  
  void add(House h) {
    nhouses++;
    totalArea += h.h * h.w;
    houses.add(h);
    if (houses.size() <= 1) {
      h.id = 0;
    } else {
      h.id = houses.get(houses.size() - 2).id + 1; // take id of last house + 1
    }
    adjacent.add(new ArrayList<Integer>());
  }
  
  void add(Person p) {
    npersons++;
    persons.add(p);
    // The first person is given the virus
    if (npersons == 1) {
      ninfected++;
      ncases++;
      p.setPatientZero();
    }
  }
  
  void add(Road r) {
    roads.add(r);
    adjacent.get(r.h1.id).add(r.h2.id);
    adjacent.get(r.h2.id).add(r.h1.id);
  }
  
  boolean isAdjacent(House h1, House h2) {
    for (int id : adjacent.get(h1.id)) {
      if (id == h2.id) {
        return true;
      }
    }
    return false;
  }
  
  void setInfected(Person p) {
    ninfected++;
    p.infected = true;
  }
  
  void setInfected(int i) {
    ninfected++;
    persons.get(i).infected = true;
  }
  
  House randomHouse() {
    return houses.get(floor(random(0, houses.size() - 0.01)));
  }
}
