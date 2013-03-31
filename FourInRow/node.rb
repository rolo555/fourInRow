MAXPLAYER = 1
MINPLAYER = 2

class Node
  attr :state
  attr :childrens
  
  ROWSIZE = 6
  COLUMNSIZE = 7

  def initialize(state = nil)
    if (state)
      @state = Array.new(state)
    else
      @state = Array.new(ROWSIZE, Array.new(COLUMNSIZE, 0))
    end
    @childrens = Array.new
  end
  
  def generateChildrens(player)
    0.upto(COLUMNSIZE - 1) do |j|
      ROWSIZE.downto(0) do |i|
        if (@state[i][j] == 0)
          @state[i][j] = player
          newState = Node.new(@state)
          @childrens << newState
          break
        end
      end
    end
  end
  
  def getHeuristicValue
    0
  end
  
  def isFinalState
    false
  end
  
  def Node.alphaBeta(node, depth, alpha, beta, player)
    return node.getHeuristicValue if depth == 0 || node.isFinalState
    
    node.generateChildrens(player)
    if player == MAXPLAYER
      node.childrens.each do |children|
        alpha = [alpha, alphaBeta(children, depth - 1, alpha, beta, MINPLAYER)].max
        break if (alfa <= beta)
      end
      return alfa
    else
      node.childrens.each do |children|
        beta = [beta, alphaBeta(children, depth - 1, alpha, beta, MAXPLAYER)].max
        break if (beta <= alpha)
      end
      return beta
    end
  end
end