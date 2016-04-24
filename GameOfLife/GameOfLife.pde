int orgSize = 14; // in pixels
int cellSpace = 0; // in pixels
int cellSize = orgSize + cellSpace;
int numOfRows; 
int numOfCols; 
int[][] matrix1; 
int[][] matrix2; 
boolean playIsOn = false;
float updateTime = 50; // screen is updated every `updateTime` ms
float lastStop;

void setup()
{
  size(1000, 1000);
  numOfRows = height / (cellSize);
  numOfCols = (width - 200) / (cellSize);
  matrix1 = new int[numOfRows][numOfCols];
  matrix2 = new int[numOfRows][numOfCols];
  lastStop = millis();
  background(255);
  rect(width - 100, 100, 80, 40);
  text("Play", width - 100, 300);
  stroke(#4680F0);
  fill(#91DEFF);
  fillRandom();
  
  for (int i = 0; i < numOfRows; i++)
    for (int j = 0; j < numOfCols; j++)
      matrix2[i][j] = matrix1[i][j];
}

void draw()
{
  if (playIsOn && millis() - lastStop > updateTime)
  {
    background(255);
    generateNewCircle();
    fill(#91DEFF);
    stroke(#4680F0);
    displayGen();
    displayButton();
    lastStop = millis();
  }
}
void mousePressed() 
{
  if (mouseX >= width - 100 && mouseX <= width - 20 && mouseY >= 100 && mouseY <= 140 ) playIsOn = !playIsOn;
  else if (mouseX < width - 200)
  {
    int i = (int)(floor(mouseX / cellSize));
    int j = (int)(floor(mouseY / cellSize));
    if (matrix1[j][i] == 0)
    {
      fill(#91DEFF);
      stroke(#4680F0);
      rect(cellSize * i, cellSize * j, orgSize, orgSize);
      matrix1[j][i] = 1;
    }
    else
    {
      fill(255);
      stroke(255);
      rect(cellSize * i, cellSize * j, orgSize, orgSize);
      matrix1[j][i] = 0;
    }
  }
}

void fillRandom()
{
  for (int i = 0; i < numOfRows; i++)
    for (int j = 0; j < numOfCols; j++)
      matrix1[i][j] = (int)random(random(2));
}
void displayGen()
{
  float xPos, yPos;
  xPos = yPos = 0;
  for (int i = 0; i < numOfRows; i++)
  {
   for (int j = 0; j < numOfCols; j++)
   {
     if (matrix2[i][j] == 1)
     {
       rect(xPos, yPos, orgSize, orgSize);
     }
     xPos+=cellSize;
   }
   yPos+=cellSize;
   xPos = 0;
 }
}
void generateNewCircle()
{
  int n = 0;
  for (int i = 0; i < numOfRows; i++)
  {
    for (int j = 0; j < numOfCols; j++)
    {
      n = 0;   
      
      for (int k = -1 ; k < 2; k++)
      {
        for (int l = -1 ; l < 2; l++)
        {
          if ( (k!=0 || l!=0) && i+k >= 0 && j+l >= 0 && i+k < numOfRows && j+l < numOfCols)
          {
            n += matrix1[i+k][j+l];
          }
        }
      }

      if (matrix1[i][j] == 0)
      {  
        if (n == 3) matrix2[i][j] = 1;
      }
      else 
      {
        if (n < 2) matrix2[i][j] = 0;
        else if (n ==2 || n ==3) matrix2[i][j] = 1;
        else matrix2[i][j] = 0;
      }
    }
  }
  
  for (int i = 0; i < numOfRows; i++)
    for (int j = 0; j < numOfCols; j++)
      matrix1[i][j] = matrix2[i][j];
}
void displayButton()
{
  rect(width - 100, 100, 80, 40);
  fill(0);
  text("Play", width - 80, 120);
}