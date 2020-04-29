
/**
 * Write a description of class Test here.
 *
 * @author (your name)
 * @version (a version number or a date)
 */
public class Test
{
    // instance variables - replace the example below with your own
    
    // all text values are set initially to protected text
    // i did this so that read only and write only will have initial values
       private ProxyWriteText write = new ProxyWriteText();
       private ProxyReadText read = new ProxyReadText();
       private ProxyReadWriteText readwrite = new ProxyReadWriteText();
    /**
     * Constructor for objects of class Test
     */
    public Test()
    {
       
       
       System.out.println(); 
       write.Write( "HEEEELLLLLLLOOOO ");
       System.out.print(write.Read());
       
       read.Write("Its a bad ");
       System.out.print(read.Read());
       
       
       readwrite.Write(" and tommorow ");
       System.out.print(readwrite.Read());
       
    }

    
}
