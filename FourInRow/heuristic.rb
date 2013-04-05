def heuristic(board, piece)
  h = 0
  (0...board.length).each do |row|
    (0...board[row].length).each do |col|
      if ((col>=3)&& (board[row][col-1] == piece)	&& (board[row][col-2] == piece)	&& (board[row][col-3] == piece))
	     h=h+16
      end

      if ((col<=3) && (board[row][col+1] == piece) && (board[row][col+2] == piece) && (board[row][col+3] == piece))
  	   h=h+16
      end
  
  	  if ((row<=2) && (board[row+1][col] == piece) && (board[row+2][col] == piece)	&& (board[row+3][col] == piece))
  	   h=h+16
      end
  
  	  if ((col>=3) && (row<=2) && (board[row+1][col-1] == piece) && (board[row+2][col-2] == piece) && (board[row+3][col-3] == piece))
  	   h=h+16
      end
      
      if ((col<=3) && (row<=2) && (board[row+1][col+1] == piece) && (board[row+2][col+2] == piece) && (board[row+3][col+3] == piece))
  	   h=h+16
  	  end
  
      if ((col>=3) && (row>=3) && (board[row-1][col-1] == piece) && (board[row-2][col-2] == piece) && (board[row-3][col-3] == piece))
  	   h=h+16
  	  end
  
      if ((col<=3) && (row>=3) && (board[row-1][col+1] == piece) && (board[row-2][col+2] == piece) && (board[row-3][col+3] == piece))
  	    h=h+16
      end
  
  	  if ((col>=2) && (board[row][col-1] == piece) && (board[row][col-2] == piece))
  	   h=h+4
      end
  	  
  	  if ((col<=4) && (board[row][col+1] == piece) && (board[row][col+2] == piece))
  	    h=h+4
      end
  	  
  	  if ((row<=3) && (board[row+1][col] == piece) && (board[row+2][col] == piece))
  	    h=h+4
      end
  	
  	  if ((col>=2) && (row<=3) && (board[row+1][col-1] == piece) && (board[row+2][col-2] == piece))
  	    h=h+4
      end
      
      if ((col<=4) && (row<=3) && (board[row+1][col+1] == piece) && (board[row+2][col+2] == piece))
  	    h=h+4
      end
  
  	  if ((col>=2) && (row>=2) && (board[row-1][col-1] == piece) && (board[row-2][col-2] == piece))
  	   h=h+4
      end
  
  	  if ((col<=4) && (row>=2) && (board[row-1][col+1] == piece) && (board[row-2][col+2] == piece))
  	    h=h+4
      end
  
  	  if ((col>=1) && (board[row][col-1] == piece))
  	    h=h+2
      end
  
  	  if ((col<=5) && (board[row][col+1] == piece))
  	   h=h+2
      end
  	  if ((row<=4) && (board[row+1][col] == piece))
  	   h=h+2
      end
  	  
  	  if ((col>=1) && (row<=4) && (board[row+1][col-1] == piece))
  	    h=h+2
      end
  
  	  if ((col<=5) && (row<=4) && (board[row+1][col+1] == piece))
  	    h=h+2
      end
  
  	  if ((col>=1) && (row>=1) && (board[row-1][col-1] == piece))
  	   h=h+2
      end
  
  	  if ((col<=5) && (row>=1) && (board[row-1][col+1] == piece))
  	   h=h+2
      end
  
  
  	  if ((col>=3) && (board[row][col-1] == -1 * piece) && (board[row][col-2] == -1 * piece) && (board[row][col-3] == -1 * piece))
  	    h=h+14
      end
  	  if ((col<=3) && (board[row][col+1] == -1 * piece) && (board[row][col+2] == -1 * piece) && (board[row][col+3] == -1 * piece))
  	   h=h+14
      end
  
  	  if ((row<=2) && (board[row+1][col] == -1 * piece) && (board[row+2][col] == -1 * piece) && (board[row+3][col] == -1 * piece))
  	   h=h+14
      end
  
  	  if ((col>=3) && (row<=2) && (board[row+1][col-1] == -1 * piece) && (board[row+2][col-2] == -1 * piece) && (board[row+3][col-3] == -1 * piece))
  	   h=h+14
      end
      
      if ((col<=3) && (row<=2) && (board[row+1][col+1] == -1 * piece)&& (board[row+2][col+2] == -1 * piece)	&& (board[row+3][col+3] == -1 * piece))
  	   h=h+14
      end
  
  	  if ((col>=3) && (row>=3) && (board[row-1][col-1] == -1 * piece) && (board[row-2][col-2] == -1 * piece) && (board[row-3][col-3] == -1 * piece))
  	   h=h+14
      end
  
  	  if ((col<=3) && (row>=3) && (board[row-1][col+1] == -1 * piece) && (board[row-2][col+2] == -1 * piece) && (board[row-3][col+3] == -1 * piece))
  	    h=h+14
      end
  
  	  if ((col>=2) && (board[row][col-1] == -1 * piece) && (board[row][col-2] == -1 * piece))
  	   h=h+4
      end
  	  
  	  if ((col<=4) && (board[row][col+1] == -1 * piece) && (board[row][col+2] == -1 * piece))
  	    h=h+4
      end
  	  
  	  if ((row<=3) && (board[row+1][col] == -1 * piece) && (board[row+2][col] == -1 * piece))
  	    h=h+4
      end
  
  	  if ((col>=2) && (row<=3) && (board[row+1][col-1] == -1 * piece) && (board[row+2][col-2] == -1 * piece))
  	    h=h+4
      end
  
  	  if ((col<=4) && (row<=3) && (board[row+1][col+1] == -1 * piece) && (board[row+2][col+2] == -1 * piece))
  	    h=h+4
      end
  
  	  if ((col>=2) && (row>=2) && (board[row-1][col-1] == -1 * piece) && (board[row-2][col-2] == -1 * piece))
  	    h=h+4
      end
  
  	  if ((col<=4) && (row>=2) && (board[row-1][col+1] == -1 * piece) && (board[row-2][col+2] == -1 * piece))
  	    h=h+4
      end
  
  	  if ((col>=1) && (board[row][col-1] == -1 * piece))
  	    h=h+2
      end
  
    	if ((col<=5) && (board[row][col+1] == -1 * piece))
    	    h=h+2
      end
    	
    	if ((row<=4) && (board[row+1][col] == -1 * piece))
    	    h=h+2
      end
      
    	if ((col>=1) && (row<=4) && (board[row+1][col-1] == -1 * piece))
    	    h=h+2
      end
    
    	if ((col<=5) && (row<=4) && (board[row+1][col+1] == -1 * piece))
    	    h=h+2
      end
    
    	if ((col>=1) && (row>=1) && (board[row-1][col-1] == -1 * piece))
    	    h=h+2
      end
    
    	if ((col<=5) && (row>=1) && (board[row-1][col+1] == -1 * piece))
    	    h=h+2
      end
    end
  end
  h
end
