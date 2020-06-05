class Simulation {
  ArrayList<House> houses = new ArrayList<House>();
  ArrayList<Person> persons = new ArrayList<Person>();
  int npersons = 0;
  float totalArea = 0;
  float virusR = 20, virusP = 0.01;
  void update() {
    for (Person person : persons) {
      person.update();
    }
    for (int i = 0; i < persons.size(); i++) {
      for (int j = i + 1; j < persons.size(); j++) {
        Person p1 = persons.get(i), p2 = persons.get(j);
        if (p1.infected != p2.infected && random(0, 1) < virusP && dist(p1.x, p1.y, p2.x, p2.y) < virusR) {
          p1.infected = true;
          p2.infected = true;
        }
      }
    }
  }
  void display() {
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
         break;
       }
       prefix += area;
    }
    assert(persons.size() == npersons);
  }
  void add(House h) {
    totalArea += h.h * h.w;
    houses.add(h);
  }
  void add(Person p) {
    npersons++;
    persons.add(p);
  }
  int numInfected() {
    int res = 0;
    for (Person p : persons) {
      res += p.infected ? 1 : 0;
    }
    return res;
  }
}
