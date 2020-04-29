import java.util.*;

public class GreedyMove implements MoveStrategy {

    public Move selectMove(BoardGame game) {
        List<Move> moves = game.generateMoves();
        if (moves.isEmpty()) return null;
        
        int currentScore = game.getMinScore();
        Move candidateMove = null; 
  
        for (Move m : moves) {
            int score = game.evaluateMove(m);
            if (score >= currentScore) {
                candidateMove = m;
                currentScore = score;
            }
              if(m.getCol()==0  && m.getRow()==0 || m.getCol()== 7 && m.getRow()==7 ||m.getCol()==0  && m.getRow()==7 || m.getCol()==7  && m.getRow()==0 )
            {
                 score=67;
                if (score >= currentScore) {
                candidateMove = m;
                currentScore = score;
              }
            }
             if((m.getCol()==0  && m.getRow()==2 || m.getCol()== 0 && m.getRow()==5 ||m.getCol()==2  && m.getRow()==0 || m.getCol()==2  && m.getRow()==7 ||m.getCol()==5  && m.getRow()==0 || m.getCol()== 5 && m.getRow()==7 ||m.getCol()==7  && m.getRow()==2 || m.getCol()==7  && m.getRow()==5)&&score<67 )
            {
                 score = 66;
                if (score >= currentScore) {
                candidateMove = m;
                currentScore = score;
              }
            }
            if((m.getCol()==2  && m.getRow()==2 || m.getCol()== 5 && m.getRow()==5 ||m.getCol()==2  && m.getRow()==5 || m.getCol()==5  && m.getRow()==2) && score<66 )
            {
                score = 65;
                if (score >= currentScore) {
                candidateMove = m;
                currentScore = score;
              }
            }
             
        }
        return candidateMove;
    }
}
