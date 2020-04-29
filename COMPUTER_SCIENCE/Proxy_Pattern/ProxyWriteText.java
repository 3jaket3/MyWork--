
/**
 * Write a description of class ProxyWriteText here.
 *
 * @author (your name)
 * @version (a version number or a date)
 */
public class ProxyWriteText implements Text
{
    
    private RealText text;
    public ProxyWriteText()
    {
        
    }   
    public void Write(String newContent)
    {   
        if(text == null)
        {
          text = new RealText();   
        }
        text.setContent(newContent);
    }
    public String Read()
    {
        return null;
    }
    

    
}
