int numOfParts = 750;
float ellipseSize = 30;
float distance = 1;
float ellipseGrowth = 0;
float displAngle = 270; // 0 to 180
float angleSpeed = 1/10000; // degrees per frame
Vector vector = new Vector(1,1);
float r,g,b, rs, gs, bs;

void setup() {
  //size(800, 800);
  fullScreen();
  //fullScreen();
  background(255);
  noStroke();
  r = g = b = 255 - distance;
  rs = random(2);
  gs = random(2);
  bs = random(2);
}
void draw() {
  update();
}
//void mousePressed() { update(); }
//void mouseDragged() { update(); }


void update()
{
  r = g = b = distance;
  vector.x = 1;
  vector.y = 1;
  background(255);
  distance = 30 * (mouseY / (float) width);
  ellipseSize = 30 * (mouseX / (float) height);
  
  if (mouseX == 0) ellipseSize = ceil(random(20)); // on init
  float prevRad = 0;
  float displacement = 0;
  
  Vector tempV = new Vector(0,0);
  for (int i = 0; i < numOfParts; i++)
  {
    r+=rs; 
    g+=gs;
    b+=bs;
    if (r >= 255 || r<=0) rs= -rs;
    if (g >= 255 || g<=0) gs= -gs;
    if (b >= 255 || b<=0) bs= -bs;
    fill( r, g, b);
    ellipse(width/2 + vector.x, height/2 + vector.y, ellipseSize , ellipseSize);
    prevRad = ellipseSize/2;
    ellipseSize+=ellipseGrowth;
    displacement = prevRad + distance + ellipseSize/2;
    tempV = vector.mult(displacement/vector.len());
    tempV = tempV.rotate(180-displAngle);
    vector = vector.add(tempV);
  }
}
class Vector
{
  public
    float x,y;
  
  Vector(float x, float y)
  {
    this.x = x;
    this.y = y;
  }
  public String toString() { return "(" + this.x + ", " + this.y + ")";}
  public float len() { return sqrt(sq(this.x) + sq(this.y)); }
  public Vector copy(Vector v) { return new Vector(v.x, v.y); }
  public Vector mult(float factor) { return new Vector(this.x * factor, this.y * factor); }
  public Vector add(Vector v) { return new Vector(this.x + v.x, this.y + v.y); }
  public Vector sub(Vector v) { return new Vector(this.x - v.x, this.y - v.y); }
  public Vector normal1() { return new Vector(this.y, -this.x); }
  public Vector normal2() { return new Vector(-this.y, this.x); }
  public Vector rotate(float angle) { return  new Vector(
                                                        this.x * cos(radians(angle)) - this.y * sin(radians(angle)), 
                                                        this.x * sin(radians(angle)) + this.y * cos(radians(angle))
                                                        ); 
                                    }
  
}