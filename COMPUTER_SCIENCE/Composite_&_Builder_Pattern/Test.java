
/**
 * Write a description of class Test here.
 *
 * @author (your name)
 * @version (a version number or a date)
 */
public class Test
{
    // instance variables - replace the example below with your own
    
    
    public Test()
    {
        ListBuilder builder = new ListBuilder();
        String values = "(1(23)(45)(64)) ";
        int index = 0;
        char value = values.charAt(index);
        while( value != ' ')
        {
          if( value == '(')
          {
              builder.buildOpenBracket();
          }
          else if( value == ')')
          {
              builder.buildClosedBracket();
          }
          else
          {
              builder.buildElement(Character.getNumericValue(value));
          }
          index++;
          value = values.charAt(index);
          
        }
         ListComponent List = builder.getList();
         List.printValue();

    }

    
}
