import java.util.ArrayList;
/**
 * Write a description of class ListComposite here.
 *
 * @author (your name)
 * @version (a version number or a date)
 */
public class ListComposite extends ListComponent
{
    // instance variables - replace the example below with your own
    private ArrayList list;
    
    /**
     * Constructor for objects of class ListComposite
     */
    public ListComposite()
    {
        list = new ArrayList();
    }

    public void addChild(ListComponent child)
    {
            list.add(child);
    }
    public void removeChild(int index)
    {
        list.remove(index);
    }
    public ListComponent getChild(int index)
    {
       return (ListComponent)list.get(index);   
    }
    public void printValue()
    {
        System.out.printf("(");
      for(int i = 0; i < list.size(); i++)
      {
          ListComponent  L = (ListComponent)list.get(i);
          L.printValue();
      }
      System.out.printf(")");
    }
}
