class TabButton extends Button {
  private boolean click1 = false, click2 = false;
  private int index;
  House h1, h2;
  
  TabButton(float x, float y, float w, float h, int index) {
    super(x, y, w, h, Integer.toString(index + 1));
    this.index = index;
  }
  
  TabButton(float x, float y, int index) {
    super(x, y, Integer.toString(index + 1));
    this.index = index;
  }
  
  void display() {
    super.display();
  }
  
  void registerClick(float x, float y) {
    super.registerClick(x, y);
    currentSimulation = simulations.get(index);
  }
}
