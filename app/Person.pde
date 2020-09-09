// People who walk around the house
class Person {
  static final float size = 7, maxSpeed = 1.5;
  private float x, y, vx, vy, ax, ay;
  private int startTime = 0, endTime;
  boolean infected = false, patientZero = false, onRoad = false;
  private int accerationTime = 50;
  House house;
  Person(House house) {
    this.house = house;
    x = random(house.x + size, house.x + house.w - size);
    y = random(house.y + size, house.y + house.h - size);
    resetSpeed();
  }
  Person(float x, float y) {
    this.x = x;
    this.y = y;
    // The person's house is initially the nearest house that is found
    House nearestHouse = new House(0, 0, 0, 0);
    float nearestDist = Float.MAX_VALUE;
    for (House h : currentSimulation.houses) {
      if (h.contains(x, y)) {
        this.house = h;
        return;
      }
      float curDist = dist(x, y, h.centerX, h.centerY);
      if (curDist < nearestDist) {
        nearestDist = curDist;
        nearestHouse = h;
      }
    }
    this.house = nearestHouse;
  }
  void resetSpeed() {
    if (startTime < endTime) {
      return;
    }
    float ang = random(0, 2 * PI), magnitude = random(-maxSpeed, maxSpeed);
    float newVx = cos(ang) * magnitude;
    float newVy = sin(ang) * magnitude;
    ax = (newVx - vx)/accerationTime;
    ay = (newVy - vy)/accerationTime;
    endTime = startTime + accerationTime;
  }
  void update() {
    if (patientZero) {
      infected = true;
    }
    // If the person is not in the designated house, move the person along a road to their house
    if (!house.contains(x, y, size)) { 
      onRoad = true;
      float dx = (house.centerX - x)/20;
      float dy = (house.centerY - y)/20;
      float mag = sqrt(dx * dx + dy * dy);
      dx *= maxSpeed/mag;
      dy *= maxSpeed/mag;
      x += dx;
      y += dy;
      return;
    }
    // Remove acceleration after some time
    startTime++;
    if (startTime >= endTime) {
      ax = 0;
      ay = 0;
    }
    vx += ax;
    vy += ay;
    float nx = x + vx, ny = y + vy;
    if (nx - size > 0 && nx - size > house.x && nx + size < width && nx + size < house.x + house.w) {
      x = nx;
    } else {
      vx = vy = 0;
    }
    if (ny - size > 0 && ny - size > house.y && ny + size < height && ny + size < house.y + house.h) {
      y = ny; 
    } else {
      vx = vy = 0;
    }
    // Person randomly changes direction
    if (ax == 0 && ay == 0 && random(0, 1) < 0.05) {
      resetSpeed();
    }
  }
  void display() {
    noStroke();
    if (infected) {
      if (patientZero) {
        fill(0, 0, 255);
      } else {
        fill(255, 0, 0);
      }
    } else {
      fill(255, 255, 255);
      stroke(0);
      strokeWeight(1);
    }
    ellipse(x, y, 2 * size, 2 * size); 
  }
}
