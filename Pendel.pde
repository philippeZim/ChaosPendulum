class Pendelc {
  private int[] base;
  private int[] top;
  private int len;
  private float speed;
  private float angle;
  private Pendelc parent;
  private int counter;
  
  private int[] start_base;
  public Pendelc(int[] base, int len, float speed, Pendelc parent) {
    this.base = base;
    this.start_base = new int[2];
    this.start_base[0] = base[0];
    this.start_base[1] = base[1];
    this.len = len;
    this.speed = speed;
    this.parent = parent;
    this.counter = 0;
    
    this.top = new int[2];
    this.top[0] = base[0];
    this.top[1] = base[1] + len;
    this.angle = 90.;
  }
  public float getSpeed() {
    return this.speed; 
  }
  public int[] getTop() {
    return this.top; 
  }
  
  public void setBase(int[] base) {
    this.base = base; 
  }
  
  public void show() {
    fill(255, 255, 255);
    noStroke();
    stroke(255);
    line(this.base[0], this.base[1], this.top[0], this.top[1]);
    if (this.parent != null) {
      ellipse(this.top[0], this.top[1], 5, 5);
    }
    
  }
  
  public void update() {
    if (this.parent != null) {
      this.base = parent.getTop();
    } else if (counter % 600 == 0) {
      this.base = this.start_base;
      this.top[0] = this.start_base[0];
      this.top[1] = this.start_base[1] + this.len;
      this.speed += random(-10, 10) / 100.;
      counter = 0;
    }
    this.top[0] = (int) (this.base[0] + this.len * cos(this.angle));
    this.top[1] = (int) (this.base[1] + this.len * sin(this.angle));
    this.angle += this.speed;
    counter++;
  }
}

Pendelc p1;
Pendelc p2;
int counter;
void setup() {
  counter = 0;
  fullScreen();
  int[] startPos1 = {width/2, height/2};
  p1 = new Pendelc(startPos1, 200, 0.05, null);
  p2 = new Pendelc(p1.getTop(), 100, 0.1, p1);
}

void draw() {
  
  if (counter % 600 == 0) {
     background(0);
     counter = 0;
  }
  p1.show();
  p2.show();
  p1.update();
  p2.update();
  counter++;
}
