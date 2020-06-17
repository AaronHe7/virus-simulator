class Message {
  float x, y;
  private int tickReset = 300;
  private String message = "";
  private int tick = 0;
  
  Message(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  void clear() {
    message = "";
    tick = 0;
  }
  
  void setMessage(String s) {
    tick = 0;
    message = s;
  }
  
  void display() {
    tick++;
    textAlign(TOP, LEFT);
    fill(255, 0, 0, 255 * sqrt(1 - pow(((float)tick/tickReset), (float)2)));
    textSize(20);
    text(message, x, y);
    if (tick >= tickReset) {
      clear();
    }
  }
}
