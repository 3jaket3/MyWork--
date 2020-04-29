
/**
 * Write a description of class Test here.
 *
 * @author (your name)
 * @version (a version number or a date)
 */
public class Test
{

    public Test()
    {
        ArrayListSubject list = new ArrayListSubject();
        ArrayListObserver obs = new ArrayListObserver(list);
        list.attach(obs);
        list.append(4);
        list.append(5);
        list.append(9);
        list.delete(4);
        list.delete(9);
        list.delete(10);
        // 10 is not in list but says item being deleted
        // not sure but failed to delete 10 and
        // a bunch of stuff
        // super cool thing like when u use terminal and it tells
        // u stuff back
       
    }

}
