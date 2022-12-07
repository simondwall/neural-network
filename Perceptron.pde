class Perceptron
{
  private float[] weights;
  private float c;
  
  Perceptron(String filename, int size, float learningConstant)
  {
    loadWeights(filename, size);
    c = learningConstant;
  }
  
  float[] getInputAnswer(float answer)
  {
    float[] flt = new float[weights.length];
    for(int i = 0; i < flt.length; i++)
    {
      flt[i] = answer / weights[i];
    }
    return flt;
  }

  void train(float[] input, float answer)
  {
    int result = guess(input);
    
    float error = answer - result;
    
    for(int i = 0; i < weights.length; i++)
    {
      weights[i] += c * error * input[i];
    }      
  }
  
  void saveWeights(String filename)
  {
    saveStrings("PerceptronData/" + filename + ".txt", str(weights));
  }
  
  void loadWeights(String filename, int size)
  {
    try
    {
      weights = float(loadStrings("PerceptronData/" + filename + ".txt"));
    }
    catch(Exception e)
    {
      generateWeights(size);
    }
  }

  void generateWeights(int alength)
  {
    weights = new float[alength];
  
    for(int i = 0; i < alength - 1; i++)
    {
      weights[i] = random(-1,1);
    }
  }
  
  int guess(float[] input)
  {
    float sum = 0;
    
    for(int i = 0; i < input.length; i++)
    {
      sum += weights[i] * input[i];
    }
    
    return function(sum);
  }
  
  int function(float num)
  {
    if(num > 0)
    {
      return 1;
    }
    return -1;
  }
  
  float[] getWeights()
  {
    return weights;
  }
}