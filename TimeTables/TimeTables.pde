float radius = 300;
float mod = 200;
float factor = 2;
Vector initialPos = new Vector(-radius, 0);
float rotateAngle = 360 / mod;
float r, g, b;
float rs, gs, bs;
boolean playIsOn = true;

void setup()
{
  fullScreen();
  background(255);
  fill(255);
  stroke(0);
  strokeWeight(1);
  ellipse(width/2, height/2, 2*radius, 2*radius);
  r = random(255);
  g = random(255);
  b = random(255);
  rs = random(10);
  gs = random(10);
  bs = random(10);
  
  //drawOnce();
}
void draw()
{
  if (playIsOn)
   presentation(); 
}
void mousePressed() { playIsOn = !playIsOn; }
void presentation()
{
  background(255);
  fill(0);
  textSize(30);
  text("Factor is: " + factor, width - 350, 300);  
  stroke(r, g, b);
  fill(255);
  ellipse(width/2, height/2, 2*radius, 2*radius);
  drawOnce();
  factor+=0.05;
  if (r + rs < 0 || r + rs > 240) rs = -rs;
  if (g + gs < 0 || g + gs > 240) gs = -gs;
  if (b + bs < 0 || b + bs > 240) bs = -bs;
  r+=rs;
  g+=gs;
  b+=bs;
}
void drawOnce()
{
  Vector pos;
  Vector prevPos; 
  for (int i = 0; i < mod; i++)
  {
    prevPos = initialPos.rotate(i * rotateAngle);
    pos = initialPos.rotate(i * factor * rotateAngle);
    line(width/2 + prevPos.x, height/2 + prevPos.y, width/2 + pos.x, height/2 + pos.y);  
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