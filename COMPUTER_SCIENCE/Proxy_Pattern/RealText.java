
/**
 * Write a description of class Text here.
 *
 * @author (your name)
 * @version (a version number or a date)
 */
public class RealText implements Text
{

    private String Content = " protected text";
    // i changed read and write so that outside this file
    // noone could know the names of the methods in Realtext 
    // that do something
    
    protected RealText()
    {
        
    }
    public void setContent(String newContent)
    {
        this.Content = newContent;
    }
    public String getContent()
    {
        return Content;
    }
    public String Read()
    {
       return null;
    }
   public void Write(String newContent)
    {
        
    }
}
