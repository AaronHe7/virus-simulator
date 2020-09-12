// Graphs the spread of the virus
class Graph {
  // Array of all arrays of y values to be plotted
  private ArrayList<ArrayList<Integer>> graph = new ArrayList<ArrayList<Integer>>();
  private ArrayList<ArrayList<Float>> colors = new ArrayList<ArrayList<Float>>();
  public int updateFrequency = 30, time = 0;
  private float x, y, w, h;
  private float textSize = 15;
  
  // Clone graph without reference
  Graph(Graph g) {
    this(g.x, g.y, g.w, g.h);
    for (ArrayList<Integer> a : g.graph) {
      graph.add(new ArrayList<Integer>());
      for (int e : a) {
        graph.get(graph.size() - 1).add(e);
      }
    }
    for (ArrayList<Float> a : g.colors) {
      colors.add(new ArrayList<Float>());
      for (float e : a) {
        colors.get(colors.size() - 1).add(e);
      }
    }
  }
  
  Graph(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  void addLine(float r, float g, float b) {
    ArrayList<Float> c = new ArrayList<Float>();
    c.add(r);
    c.add(g);
    c.add(b);
    colors.add(c);
    graph.add(new ArrayList<Integer>());
  }
  
  void addEntry(int i, int val) {
    graph.get(i).add(val);
  }
  
  void update() {
    time++;
  }
    
  void display() {
    stroke(0);
    textSize(textSize);
    strokeWeight(1);
    // X-axis
    line(x, y + h, x + w, y + h);
    // Y-axis
    line(x, y, x, y + h);
    
    // Maximum y-value of graph
    int max = 0;
    for (ArrayList<Integer> l : graph) {
      for (int e : l) {
        max = Math.max(e, max);
      }
    }
    
    int nticks = 4;
    fill(0);
    // Ticks on x-axis
    textAlign(CENTER, TOP);
    for (int i = 1; i <= nticks; i++) {
      text(String.format("%.1f", (float)(time/updateFrequency) * i/nticks), this.x + (float)i/nticks * w, this.y + h);
    }
    
    // Ticks on y-axis
    textAlign(RIGHT, CENTER);
    text("0", this.x - 5, this.y + this.h);
    for (int i = 1; i <= nticks; i++) {
      text(String.format("%.1f", (float)max * i/nticks), this.x - 5, this.y - (float)i/nticks * h + h);
    }
    
    for (int i = 0; i < graph.size(); i++) {
      stroke(colors.get(i).get(0), colors.get(i).get(1), colors.get(i).get(2));
      ArrayList<Integer> l = graph.get(i);
      int entries = l.size();
      if (entries <= 0) {
        continue;
      }
      float px = 0, py = 0;
      for (int j = 0; j < entries; j++) {
        float x = (float)j/entries * w, y = h - ((float)l.get(j)/max * h);
        if (j > 0) {
          line(px + this.x, py + this.y, x + this.x, y + this.y);
        }
        px = x;
        py = y;
      }
    }
  }
}
