class Person {
  float size = 7, maxSpeed = 1.5;
  float x, y, vx, vy, ax, ay;
  int startTime = 0, endTime;
  boolean infected = false;
  int accerationTime = 50;
  House house;
  Person(House house) {
    this.house = house;
    x = random(house.x + size, house.x + house.w - size);
    y = random(house.y + size, house.y + house.h - size);
    resetSpeed();
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
    if (ax == 0 && ay == 0 && random(0, 1) < 0.05) {
      resetSpeed();
    }
  }
  void display() {
    noStroke();
    if (infected) {
      fill(255, 0, 0);
    } else {
      fill(255, 255, 255);
      stroke(0);
      strokeWeight(1);
    }
    ellipse(x, y, 2 * size, 2 * size); 
  }
}
