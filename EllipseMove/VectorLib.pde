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