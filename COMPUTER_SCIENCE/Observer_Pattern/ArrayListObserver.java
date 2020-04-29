
/**
 * Write a description of class ArrayListObserver here.
 *
 * @author (your name)
 * @version (a version number or a date)
 */
public class ArrayListObserver implements Observer
{
    private int observerState;
    private ArrayListSubject Subject;
    public ArrayListObserver(ArrayListSubject list)
    {
        Subject = list;
    }
    public void update()
    {
        if(observerState > Subject.getState())
        {
         System.out.println("an item being deleted");   
        }
        observerState = Subject.getState();
    }
}
