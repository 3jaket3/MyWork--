
/**
 * Write a description of class ProxyReadWriteText here.
 *
 * @author (your name)
 * @version (a version number or a date)
 */
public class ProxyReadWriteText implements Text
{   
    private RealText text;
    public ProxyReadWriteText()
    {
         
    }
    public String Read()
    {
       if(text != null)
      {
          return text.getContent();
      }
      else
      {
         text = new RealText();
         return text.getContent();
        }
    }
    
    public void Write(String newContent)
    {
      if(text == null)
        {
          text = new RealText();   
        }
        text.setContent(newContent);
    }
}
