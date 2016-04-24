float bigSemiAxis = 300;
float littleSemiAxis = 160;
float startX;
float startY;
Vector dir = new Vector(0, -littleSemiAxis);
Vector rotatedDir = dir;
float step = 2;
float compStep = 1;
float angle = 0; // angle to rotate axis to in degrees
float angleInc = 10; // value to increment the angle by when ellipse is drawn
int directionSwitched = 0;
int numOfCycles = 360/ (int)angleInc;

void setup()
{
  size(800, 800);
  background(255);
  noStroke();
  startX = width / 2;
  startY = height / 2 - littleSemiAxis;
  
  //fill(255);
  //stroke(255, 0, 0);
  //ellipse(width/2, height/2, 2*bigSemiAxis, 2*littleSemiAxis); // ellipse to move over
  noStroke();
  
  while (numOfCycles > 0)
  {
  calcCoords();
  fill(40, 40, 40);
  ellipse(width/2 + rotatedDir.x, height/2 + rotatedDir.y, 5, 5); // moving ellipse
  }
}

void draw()
{
  // ************ uncomment to see smooth drawing ************
  //background(255);
  //calcCoords();
  //noStroke();
  //fill(40, 40, 40);
  //ellipse(width/2 + rotatedDir.x, height/2 + rotatedDir.y, 10, 10); // moving ellipse
  // ************ uncomment above to see smooth drawing ************
  
  
  //ellipse();
}

void calcCoords()
{
  if (abs(dir.x) == bigSemiAxis ) 
  { 
    step = -step; 
    compStep = -compStep; 
    directionSwitched++; 
  }
  
  if (dir.x + step + 4 >= bigSemiAxis || dir.x + step - 4 <= -bigSemiAxis)
  {
    if (dir.x + compStep > bigSemiAxis)
      dir.x = bigSemiAxis;
    else if (dir.x + compStep < -bigSemiAxis)
      dir.x = -bigSemiAxis;
    else
      dir.x += compStep;
  }
  else
    dir.x += step;
  dir.y = sqrt(sq(littleSemiAxis) * (1 - sq(dir.x)/sq(bigSemiAxis)));
  if (step > 0) dir.y = -dir.y;
  
  if (directionSwitched == 2 && dir.x > 0) 
  { 
    angle+=angleInc; 
    directionSwitched = 0;
    numOfCycles--;
  }
  rotatedDir = dir.rotate(angle);
}