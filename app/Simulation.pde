class Simulation {
  ArrayList<House> houses = new ArrayList<House>();
  ArrayList<Person> persons = new ArrayList<Person>();
  ArrayList<Road> roads = new ArrayList<Road>();
  ArrayList<ArrayList<Integer>> adjacent = new ArrayList<ArrayList<Integer>>();
  private int npersons = 0, ninfected = 0, ndead = 0, nhouses;
  private float totalArea = 0;
  private float virusR = 20, virusP = 0.01, healP = 0.0003, deathP = 0.00015, moveP = 0.0005;
  
  void update() {
    background(255, 255, 255);
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
        if (inContact && random(0, 1) < virusP) {
          p1.infected = true;
          ninfected++;
        }
      } else if (!p1.patientZero || (ninfected + ndead >= (npersons + ndead)/2 && npersons >= 20)) {
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
  
  void display() {
    for (Road r : roads) {
      r.display();
    }
    for (House h : houses) { 
      h.display();
    }
    for (Person p : persons) {
      p.display();
    }
    textAlign(CENTER, TOP);
    fill(0);
    textSize(30);
    text("Virus Simulator", width/2, 20);
    textSize(20);
    text("Aaron He", width/2, 60);
    textAlign(RIGHT, TOP);
    text("Infected: " + ninfected, width - 10, 20);
    text("Dead: " + ndead, width - 10, 50);
  }
  
  void addRandomPerson() {  
    float prefix = 0; // make people in house proportional to area
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
    if (npersons == 1) {
      ninfected++;
      p.patientZero = true;
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
