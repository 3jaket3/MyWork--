import java.util.ArrayList;
/**
 * Write a description of class ListBuilder here.
 *
 * @author (your name)
 * @version (a version number or a date)
 */
public class ListBuilder
{
    // instance variables - replace the example below with your own
    private int index = 0;
    private int size = 0;
    private ListComponent List;
    /**
     * Constructor for objects of class ListBuilder
     */
    public ListBuilder()
    {
        
    }
    public void buildOpenBracket()
    {
        if(List == null)
        {
         List = new ListComposite();
       }
       else
       {
        List.addChild(new ListComposite());
        size++;
       }
        
    }
    public void buildElement(int number)
    {
        if(size > index)
        {
          List.getChild(index).addChild(new Item(number));   
        }
        else
        {
          List.addChild(new Item(number));
          index++;
          size++;
        }
    }
    public void buildClosedBracket()
    {
      index++;   
    }
    public ListComponent getList()
    {
        return List;
    }
}
