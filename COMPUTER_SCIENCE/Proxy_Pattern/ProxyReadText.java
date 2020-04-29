
/**
 * Write a description of class ProxyReadText here.
 *
 * @author (your name)
 * @version (a version number or a date)
 */
public class ProxyReadText implements Text
{
    // instance variables - replace the example below with your own
    private RealText text;

    /**
     * Constructor for objects of class ProxyReadText
     */
    public ProxyReadText()
    {
        
    }

    public void Write(String newContent)
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
}
