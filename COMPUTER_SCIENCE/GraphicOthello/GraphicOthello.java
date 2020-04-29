import java.awt.*;
import javax.swing.*;
import java.awt.event.*;
import javax.swing.border.LineBorder;



/**
 * Write a description of class GraphicOthello here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class GraphicOthello extends Othello
{

  private Othello O;  // this isnt in the uml diagram but makes accessabilty and reset easy i know it could be done without but dont see why you would.
  private JFrame gameFrame ;
  private JButton[][] Grid;
  private JLabel score; // also not a in the uml
  public GraphicOthello()
  {
      O = new Othello(8,new GreedyMove());
      
      gameFrame = new JFrame("Othello");
      gameFrame.setSize(600,600);
      gameFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
      BorderLayout border = new BorderLayout();
      gameFrame.setLayout(border);
      
      JPanel P = new JPanel();
      P.setBackground(Color.black);
      P.setLayout(new GridLayout(8,8));
      ButtonListener listener = new ButtonListener(gameFrame);
      mouseListener hover = new mouseListener(gameFrame);
      Grid = new JButton[8][8];
      
      LineBorder thickBorder = new LineBorder(Color.black,3);
         for (int i = 0; i < 8; i += 1) {
            for (int j = 0; j < 8; j += 1) {
                JButton b = new JButton(" ");
                b.setFont(b.getFont().deriveFont(40.0f));
                b.addActionListener(listener);
                b.addMouseListener(hover);
                b.setActionCommand("" + i + j);
                b.setBorder(thickBorder);
                Grid[i][j]=b;
                Grid[i][j].setBackground(Color.gray);
                Grid[i][j].setForeground(Color.gray);
                P.add(b);
                 
            }
        }
      
      
      //adding strategy buttons and listner
       JButton[][] Strat = new JButton[1][3];
        gameFrame.add(P,BorderLayout.CENTER);
        JPanel P1 = new JPanel();
        P1.setLayout(new GridLayout(1,3));
        StrategyListener Slistener = new StrategyListener(gameFrame);
        
        JButton s1= new JButton("First Available Move");
        JButton s2= new JButton("Random Move");
        JButton s3= new JButton("Greedy Move");
        Strat[0][0] = s1;
        Strat[0][1] = s2;
        Strat[0][2] = s3;
        
        for(int j=0;j<3;j++)
        {
             Strat[0][j].addActionListener(Slistener);
             Strat[0][j].setActionCommand("" + j);
             Strat[0][j].setBackground(Color.white);
             Strat[0][j].setFont(Strat[0][j].getFont().deriveFont(16.0f));
             Strat[0][j].setBorder(thickBorder);
             P1.add(Strat[0][j]);
        }
         gameFrame.add(P1,BorderLayout.SOUTH);
       
         score = new JLabel("               MyScore: "+O.tally());
         score.setBackground(Color.LIGHT_GRAY);
         score.setOpaque(true);
         gameFrame.add(score,BorderLayout.PAGE_START);
         
         JButton reset = new JButton(" reset ");
         reset.setBackground(Color.red);
         reset.setBorder(new LineBorder(Color.white,1));
         reset.setFont(reset.getFont().deriveFont(22.0f));
         resetListener r = new resetListener(gameFrame);
         reset.addActionListener(r);
         
         gameFrame.add(reset,BorderLayout.EAST);
         
         gameFrame.setVisible(true);
         
      int ynOption = JOptionPane.showOptionDialog(gameFrame, "Do you want to play first?","setttings",JOptionPane.YES_NO_OPTION,JOptionPane.QUESTION_MESSAGE,null,null,null);
       if(ynOption==1)
       {  
           O.toggleTurn();
           O.machinePlay();
           O.toggleTurn();
        }
        print();
    }
  
     public static void main(String[] args) {
        new GraphicOthello();
       
    }
    
     public void print()
     {
         for (int i = 0; i < 8; i += 1) {
            for (int j = 0; j < 8; j += 1) {
                
                if(O.grid[i][j]=='_')
                {
                 Grid[i][j].setBackground(Color.gray);
                 Grid[i][j].setForeground(Color.gray);
                }
                if(O.grid[i][j]=='x')
                {
                     Grid[i][j].setForeground(Color.white);
                     Grid[i][j].setBackground(Color.black);
                }
                if(O.grid[i][j]=='o')
                {
                     Grid[i][j].setForeground(Color.black);
                     Grid[i][j].setBackground(Color.white);
                }
               
              Grid[i][j].setText(String.valueOf(O.grid[i][j]));
            }
        }
        }
    
    public class ButtonListener implements ActionListener
  { 
          private JFrame model;
    /**
     * The listener stores a reference to the game's model.
     */
    public ButtonListener( JFrame gameFrame)
    {
        this.model=model;
    }
   
    /**
     * Called when a player clicks a button to mark a square with
     * an "X" or an "O". Updates the model and the GUI.
     */
    public void actionPerformed( ActionEvent event)
    {
           JButton button = (JButton) event.getSource();
           String command = button.getActionCommand();
           int row = Integer.parseInt(command.substring(0, 1));
           int col = Integer.parseInt(command.substring(1, 2));
           Move move = new Move(row,col);
      
           if(O.canPlay(move)) // vslid player move
            {
               O.status = O.play(move);
               
               O.toggleTurn(); // o
                  if(O.generateMoves().isEmpty())//can machine play if no
               {
                   O.toggleTurn(); // x
                   if(O.generateMoves().isEmpty()) // can human play if no game over
                   {
                       O.status=O.GAME_OVER;
                    }
                  O.toggleTurn();   //o
                }
               
               if(!(O.generateMoves().isEmpty()))    //  machine can play 
                  {
                   O.status=O.machinePlay(); //machine plays
                   O.toggleTurn();  // x 
                  
                 while(O.generateMoves().isEmpty()) // while human cant play if it cant we it exits
                  {
                   O.toggleTurn();     // o 
                   O.status=O.machinePlay(); // machine plays
                   
                   if(O.status==O.NO_MOVE) // if machine cant play game over
                   {
                      O.status=O.GAME_OVER;
                      break;
                    }
                    O.toggleTurn();   //x
                   }
                  
                }
                 if(O.getTurn()=='o')  //if there are no o moves then it would exit at o turn so i make sure it isnt here , all other cases it will already be at x 
                {
                    O.toggleTurn();
                }
            }
            
            print();
           score.setText("MyScore: "+O.tally()); // update game status
           if(O.status==O.GAME_OVER) // when the game is over determine the  output message
           {
               O.determineWinner();
                switch (O.status) {
                 case X_WON: JOptionPane.showMessageDialog(gameFrame,"YOU WIN!!!"); break;
                 case O_WON: JOptionPane.showMessageDialog(gameFrame,"YOU LOSE :("); break;
                 case TIE: JOptionPane.showMessageDialog(gameFrame,"TIE..."); break;
               
                 default: break;
             }
              
            }
    }
  }
        public class resetListener implements ActionListener
  { 
    private JFrame model;
    /**
     * The listener stores a reference to the game's model.
     */
    public resetListener(JFrame gameFrame)
    {
        this.model=model;
    }
   
    /**
     * Called when a player clicks a button to mark a square with
     * an "X" or an "O". Updates the model and the GUI.
     */
    public void actionPerformed(ActionEvent event)
    {
        O = new Othello(8,new GreedyMove());
           
       int ynOption = JOptionPane.showOptionDialog(gameFrame, "Do you want to play first?","setttings",JOptionPane.YES_NO_OPTION,JOptionPane.QUESTION_MESSAGE,null,null,null);
       if(ynOption==1)
       {  
            O.toggleTurn();
           O.machinePlay();
           O.toggleTurn();
        }

       
        print();
       }
    }
      public class StrategyListener implements ActionListener
  { 
    private JFrame model;
    /**
     * The listener stores a reference to the game's model.
     */
    public StrategyListener(JFrame model)
    {
       this.model=model;
    }
   
    /**
     * Called when a player clicks a button to mark a square with
     * an "X" or an "O". Updates the model and the GUI.
     */
    public void actionPerformed(ActionEvent event) // when you inspect Othello after the change it it must be closed and reopend.
    {
        JButton button = (JButton) event.getSource();
        String command = button.getActionCommand();
        int col = Integer.parseInt(command.substring(0, 1));
        MoveStrategy newStrategy = strategy;
        switch(col){
        case 0: newStrategy =new FirstAvailableMove();break;
        case 1: newStrategy = new RandomMove();break;
        case 2: newStrategy =new GreedyMove();break;
       }
      O.setMoveStrategy(newStrategy);
        
       }
    }
    
        public class mouseListener implements MouseListener
  { 
    private JFrame model;
    /**
     * The listener stores a reference to the game's model.
     */
    public mouseListener(JFrame gameFrame)
    {
        this.model=model;
    }
   
    /**
     * Called when a player clicks a button to mark a square with
     * an "X" or an "O". Updates the model and the GUI.
     */
    public void mouseEntered(MouseEvent event)
    {
        JButton button = (JButton) event.getSource();
      
        String command = button.getActionCommand();
        int row = Integer.parseInt(command.substring(0, 1));
        int col = Integer.parseInt(command.substring(1, 2));
        Move move = new Move(row,col);
        
         if(O.grid[row][col]=='_'&& getTurn()==turn)
        {
         if(O.canPlay(move)){
           Grid[row][col].setForeground(Color.green);
           Grid[row][col].setBackground(Color.green);
         }
         if(!(O.canPlay(move))){
           Grid[row][col].setForeground(Color.red);
           Grid[row][col].setBackground(Color.red);
         }
        }
    }
    public void mouseExited(MouseEvent event)
    {
        JButton button = (JButton) event.getSource();
        String command = button.getActionCommand();
        int row = Integer.parseInt(command.substring(0, 1));
        int col = Integer.parseInt(command.substring(1, 2));
         if(O.grid[row][col]=='_')
         {
           Grid[row][col].setBackground(Color.gray);
           Grid[row][col].setForeground(Color.gray);
         }
    }
    public void mouseClicked(MouseEvent event)
    {
    }
    public void mousePressed(MouseEvent event)
    {
    }
    public void mouseReleased(MouseEvent event)
    {
    }
    }
  }


