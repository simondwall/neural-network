class Trainer
{
  private float[] input;
  private String answer;
  
  Trainer(int index)
  {
    loadInputs(index);
  }
  
  float[] getInput()
  {
    return input;
  }
  
  String getAnswer()
  {
    return answer;
  }
  
  float getPixelFromInput(int index)
  {
    return input[index];
  }
  
  void loadInputs(int index)
  {
    String[] s = loadStrings("Formen.txt");
    String[] _s = split(s[index], '|');
    float[] img = new float[_s.length-1];
    
    for(int i = 0; i < img.length; i++)
    {
      img[i] = float(_s[i]);
    }
    
    input = img;
    answer = _s[_s.length-1];
  }
}