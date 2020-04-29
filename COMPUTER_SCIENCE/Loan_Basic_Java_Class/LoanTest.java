import org.junit.Test;
import static org.junit.Assert.*;
/**
 * Write a description of class Test here.
 *
 * @author (your name)
 * @version (a version number or a date)
 */
// Junit test cases for setLoanAmount (to test the exception) and getMonthlyPayment
public class LoanTest
{
    Loan loan1 = new Loan(2.5,1,1000);
    
    public void monthlyPaymentTest() throws Exception{
        
       double monthlyInterestRate = loan1.getAnnualInterestRate() / 1200;
       double monthlyPayment = loan1.getLoanAmount() * monthlyInterestRate / (1 -
       (1 / Math.pow(1 + monthlyInterestRate, loan1.getNumberOfYears() * 12)));  
       assertTrue(monthlyPayment == loan1.getMonthlyPayment());
    }
   
    public void setLoanAmountTest() throws Exception{
     loan1.setLoanAmount(2000);
     assertTrue(loan1.getLoanAmount() == 2000);
     loan1.setLoanAmount(-1000);
        
        
    }
}
