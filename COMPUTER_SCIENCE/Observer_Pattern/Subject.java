
/**
 * Write a description of interface Subject here.
 *
 * @author (your name)
 * @version (a version number or a date)
 */
abstract class Subject
{
    private Observer o;
    public  void attach(Observer obs)
    {
     o = obs;   
    }
    public  void detatch(Observer obs)
    {
      o = null;   
    }
    public void Notify()
    {
      o.update();   
    }
    
}
