class Simulation {
  ArrayList<House> houses = new ArrayList<House>();
  ArrayList<Person> persons = new ArrayList<Person>();
  ArrayList<Road> roads = new ArrayList<Road>();
  ArrayList<ArrayList<Integer>> adjacent = new ArrayList<ArrayList<Integer>>();
  int npersons = 0, ninfected = 0, ndead = 0;
  float totalArea = 0;
  float virusR = 20, virusP = 0.01, healP = 0.0003, deathP = 0.00015, moveP = 0.0005;
  void update() {
    for (Person person : persons) {
      if (random(0, 1) < moveP && !person.onRoad) { // switch houses at random
         House newhouse = houses.get(floor(random(0, houses.size() - 0.01)));
         for (int nid : adjacent.get(newhouse.id)) { // check if two houses are connected
            if (nid == person.house.id) {
              person.house = newhouse;
              break;
            }
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
      } else if (!p1.patientZero || ninfected + ndead >= npersons/2) {
        p1.patientZero = false;
        if (random(0, 1) < healP) {
          ninfected--;
          p1.infected = false;
        } else if (random(0, 1) < deathP) {
          ndead++;
          ninfected--;
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
  }
  void addRandomPerson() {
    npersons++;
    float prefix = 0; // make people in house proportional to area
    float rand = random(0, totalArea);
    for (House h : houses) {
       float area = h.h * h.w;
       if (rand >= prefix && rand < prefix + area) {
         persons.add(new Person(h));
         if (npersons == 0) {
           persons.get(npersons - 1).patientZero = true;
         }
         break;
       }
       prefix += area;
    }
    assert(persons.size() == npersons);
  }
  void add(House h) {
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
  }
  void add (Road r) {
    roads.add(r);
    adjacent.get(r.h1.id).add(r.h2.id);
    adjacent.get(r.h2.id).add(r.h1.id);
  }
  void setInfected(Person p) {
    ninfected++;
    p.infected = true;
  }
  void setInfected(int i) {
    ninfected++;
    persons.get(i).infected = true;
  }
}
