
public class Item extends ListComponent 
{
    // instance variables - replace the example below with your own
    private int Number;

    /**
     * Constructor for objects of class Item
     */
    public Item(int number)
    {
        Number = number;
    }
    public void printValue()
    {
        System.out.printf(""+Number);
    }
    
}
