Trainer t;
int trainerIndex;
Perceptron[] output = new Perceptron[2];
Perceptron[] hidden = new Perceptron[20];
int SIZE = 24;
int trains;
int wrongs;
float c = 0.05;

void setup() 
{
  trainerIndex = 0;
  getTrainingInput();
  trains = 0;
  for(int i = 0; i < hidden.length; i++)
  {
    hidden[i] = new Perceptron("hidden" + i, (int) sq(SIZE), c/2);
  }
  for(int i = 0; i < output.length; i++)
  {
    output[i] = new Perceptron("output" + i, hidden.length, c);
  }
  
  size(600,600);
  noStroke();
}

void draw()
{
  drawLastImage();
  fill(128);
  showInfo();
}

void showInfo()
{
  if(output[0].guess(getHiddenOut()) >= 0)
  {
    if(output[1].guess(getHiddenOut()) >= 0)
    {
      text("Beides",50,50);
    }
    else
    {
      text("Rechteck",50,50);
    }
  }
  else if(output[1].guess(getHiddenOut()) >= 0)
  {
    text("Kreis",50,50);
  }
  else
  {
    text("Nichts",50,50);
  }
  
  text("Bild: "+trainerIndex,50,75);
  text(wrongs+"/"+trains,50,100);
}

void drawLastImage()
{
  float[] pxls = t.getInput();
  int cell = width / SIZE;
  int row = 0;

  for(int i = 0; i < pxls.length; i++)
  {
    fill(pxls[i]*255);
    rect(i*cell-row*SIZE*cell,row*cell,cell,cell);
    
    if(i % SIZE == SIZE -1)
    {
      row++;
    }
  }
}

void keyPressed()
{
  if(key == ENTER)
  {
    trainOutputs();
    saveAllWeights();
    getTrainingInput();
    trains++;
    if(!mistake())
    {
      wrongs++;
    }
  }
}

void saveAllWeights()
{
  for(int i = 0; i < output.length; i++)
  {
    output[i].saveWeights("output"+i);
  }
  
  for(int i = 0; i < hidden.length; i++)
  {
    hidden[i].saveWeights("hidden"+i);
  }
}

void getTrainingInput()
{
  t = new Trainer(trainerIndex);
  trainerIndex++;
}

boolean mistake()
{
  if(t.getAnswer().equals("R"))
  {
    if(output[0].guess(getHiddenOut()) >= 0 && output[1].guess(getHiddenOut()) < 0)
    {
      return true;
    }
  }
  else
  {
    if(output[1].guess(getHiddenOut()) >= 0 && output[0].guess(getHiddenOut()) < 0)
    {
      return true;
    }
  }
  return false;
}

void trainOutputs()
{
  trainOuts();
  trainHidden();
}

void trainHidden()
{
  for(int i = 0; i < hidden.length; i++)
  {
    if(t.getAnswer().equals("R"))
    {
      hidden[i].train(t.getInput(), output[0].getInputAnswer(1)[i]);
      hidden[i].train(t.getInput(), output[1].getInputAnswer(-1)[i]);
    }
    else
    {
      hidden[i].train(t.getInput(), output[1].getInputAnswer(1)[i]);
      hidden[i].train(t.getInput(), output[0].getInputAnswer(-1)[i]);
    }
  }
}

float[] getHiddenOut()
{
  float[] flt = new float[hidden.length];
  for(int i = 0; i < hidden.length; i++)
  {
    flt[i] = hidden[i].guess(t.getInput());
  }
  return flt;
}

void trainOuts()
{
  if(t.getAnswer().equals("R"))
  {
    output[0].train(getHiddenOut(), 1);
    output[1].train(getHiddenOut(), -1);
  }
  else
  {
    output[0].train(getHiddenOut(), -1);
    output[1].train(getHiddenOut(), 1);
  }
}