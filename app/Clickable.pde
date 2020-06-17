interface Clickable {
  void display();
  boolean contains(float x, float y);
  void registerClick(float x, float y);
  boolean active();
  void activate(boolean active);
}
