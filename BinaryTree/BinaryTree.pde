float scrW, scrH;
float rootLength = 300;
int treeDepth = 10;
int numOfNodes = 4;
float angle = 60; // degrees
float ratioBasis = 2.0/3;

void setup()
{
  fullScreen();
  stroke(0);
  strokeWeight(1);
  drawTree();
}

void draw()
{
  if (pmouseX - mouseX != 0 || pmouseY - mouseY !=0 ) drawTree();
}
 
void drawTree()
{
  background(255);
  rootLength = 150 + 200 * (1.0*mouseX/width);
  angle = 180 * (1.0*mouseY/height);
  line(width/2, height, width/2, height - rootLength );
  drawBrench(0, width/2, height, width/2, height-rootLength);
}

void drawBrench(int level, float px, float py, float x, float y)
{
  if (level < treeDepth)
  {    
    Vector v1 = new Vector(x - px, y - py);
    v1 = v1.mult(ratioBasis).rotate(-angle);
    Vector v2 = v1.rotate(2*angle);

    line(x, y, x + v1.x, y + v1.y);
    line(x, y, x + v2.x, y + v2.y);
    
    drawBrench(level+1, x, y, x + v1.x, y + v1.y);
    drawBrench(level+1, x, y, x + v2.x, y + v2.y);
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