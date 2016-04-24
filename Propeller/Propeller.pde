Vector direct;
Vector axisPoint;
int startTime = 0;
int propellerLaunched = 0; 

PShape[] blades = new PShape[1];  // The PShape object

float edgeWidth = 65;
float centerWidth = 25;
float angle = 30;
int i = 0;

void setup() 
{
  size(900, 900);
  background(255);
  noStroke();
  direct = new Vector(0, 300);
  axisPoint = new Vector(350, 350);
  updateBlade();
  for (int i = 0; i < blades.length; i++)
      shape(blades[i], 0, 0);
  startTime = millis();
}

void draw() {
  background(255);
  
  
  if (propellerLaunched == 1)
  {
    if (millis() - startTime <= 5000)
      angle = (millis() - startTime)/100;
    
    updateBlade();
    fill(178, 32, 12); // change launchButton color to "pressed"
    
  }
  if (propellerLaunched == 0)
  {
    
    if (startTime - millis()>= 0){
      angle = (startTime - millis())/100;
      updateBlade();
    }
    fill(255, 45, 17); // change launchButton color to "released"
  }
  
  
   
  for (int i = 0; i < blades.length; i++)
      shape(blades[i], 0, 0);
  ellipse(width - 150, height - 150, 100, 100); // start button
  fill(232, 172, 18);
  ellipse(axisPoint.x, axisPoint.y, 45, 45); // propeller axis ellipse
}
void mousePressed()
{
  if (sq(mouseX - (width - 150) ) + sq(mouseY - (height - 150) ) <= sq(50)) // if launch button is pressed
  {
    if (propellerLaunched == 1)
    {
      propellerLaunched = 0;
      if (millis() - startTime <= 5000)
        startTime = 2*millis() - startTime;
      else
        startTime = millis() + 5000;
    }
    else
    {
      propellerLaunched = 1;
      startTime = millis();
    }
  }
}
void updateBlade()
{
  direct = direct.rotate(angle);
 
  Vector tempDirect = direct;
  for (int i = 0; i < blades.length; i++)
  {
    Vector wideSide = tempDirect.normal1();
    Vector shortSide = tempDirect.normal1();
    wideSide = wideSide.mult(edgeWidth/wideSide.len());
    shortSide = shortSide.mult(centerWidth/shortSide.len());
  
    blades[i] = createShape();
    blades[i].beginShape();
    blades[i].fill(255, 215, 32);
    blades[i].noStroke();
    
    blades[i].vertex(axisPoint.sub(tempDirect).sub(wideSide).x, axisPoint.sub(tempDirect).sub(wideSide).y);
    blades[i].vertex(axisPoint.sub(tempDirect).add(wideSide).x, axisPoint.sub(tempDirect).add(wideSide).y);
    blades[i].vertex(axisPoint.add(shortSide).x, axisPoint.add(shortSide).y);
    blades[i].vertex(axisPoint.add(tempDirect).add(wideSide).x, axisPoint.add(tempDirect).add(wideSide).y);
    blades[i].vertex(axisPoint.add(tempDirect).sub(wideSide).x, axisPoint.add(tempDirect).sub(wideSide).y);
    blades[i].vertex(axisPoint.sub(shortSide).x, axisPoint.sub(shortSide).y);
    
    blades[i].endShape();
    
    tempDirect = tempDirect.rotate(90);
  }
}