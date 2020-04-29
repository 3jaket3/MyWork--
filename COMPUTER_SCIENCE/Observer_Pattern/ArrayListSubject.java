import java.util.ArrayList;
/**
 * Write a description of class ArrayListSubject here.
 *
 * @author (your name)
 * @version (a version number or a date)
 */
public class ArrayListSubject extends Subject
{
    private ArrayList list;
    private int state;
    public ArrayListSubject()
    {
        list = new ArrayList();
    }
   
    public void append(Object obj)
    {
        list.add(obj);
        this.setState(state+1);
        this.Notify();
    }
    public void delete(Object obj)
    {
        list.remove(obj);
        this.setState(state-1);
        this.Notify();
    }
    public int getState()
    {
        return state;
    }
    public void setState(int State)
    {
        state = State;
    }
    
    
}
