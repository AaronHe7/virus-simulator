// Graphs the spread of the virus
class Graph {
  // Array of all arrays of y values to be plotted
  private ArrayList<ArrayList<Integer>> graph = new ArrayList<ArrayList<Integer>>();
  public int updateFrequency = 60;
  private float x, y, w, h;
  
  Graph(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  void addLine() {
    graph.add(new ArrayList<Integer>());
  }
  
  void addEntry(int i, int val) {
    graph.get(i).add(val);
  }
  
  void display() {
    stroke(0);
    strokeWeight(1);
    // X-axis
    line(x, y + h, x + w, y + h);
    // Y-axis
    line(x, y, x, y + h);
    for (ArrayList<Integer> line : graph) {
      int entries = line.size();
      if (entries == 0) {
        continue;
      }
      int min = line.get(0), max = line.get(0);
      for (int e : line) {
        min = Math.min(min, e);
        max = Math.min(max, e);
      }
      float px = -1, py = -1;
      for (int i = 0; i < entries; i++) {
        float x = (float)i/entries * w, y = (float)line.get(i)/(max - min) * h;
        if (i > 0) {
          line(px + this.x, py + this.y, x + this.x, y + this.y);
        }
        px = x;
        py = y;
      }
    }
  }
}
