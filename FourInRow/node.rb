require_relative 'heuristic'

class Node
  attr :state
  attr :childrens
  attr :value, true
  
  ROWSIZE = 6
  COLUMNSIZE = 7 
  MAXPLAYER = 1
  MINPLAYER = -1

  def initialize(ste = nil)
    if (!ste.nil?)
      @state = Array.new(ROWSIZE) { |i| Array.new(COLUMNSIZE) { |j| ste[i][j]}}
    else
      @state = Array.new(ROWSIZE) {Array.new(COLUMNSIZE) {0}}
    end
    @childrens = Array.new
    @value = 0
  end
  
  def generateChildrens(player)
    0.upto(COLUMNSIZE - 1) do |j|
      (ROWSIZE - 1).downto(0) do |i|
        if (@state[i][j] == 0)          
          newState = Node.new(@state)          
          newState.state[i][j] = player          
          @childrens << newState
          break
        end
      end
    end
  end
  
  def getHeuristicValue
    if isDraw
      return 0
    elsif minPlayerWon
      return -10000
    elsif maxPlayerWon
      return 10000
    else
      return heuristic(@state, MAXPLAYER) - heuristic(@state, MINPLAYER)
    end
  end
  
  def isDraw
    0.upto(ROWSIZE - 1) do |i|
      0.upto(COLUMNSIZE - 1) do |j|
        return false if @state[i][j] == 0
      end
    end
    true
  end
  
  def maxPlayerWon
    0.upto(ROWSIZE - 1) do |i|      
      0.upto(COLUMNSIZE - 1) do |j|
        sum = 0
        0.upto(3) do |k|
          break if i + k >= ROWSIZE
          
          sum += 1 if @state[i + k][j] == MAXPLAYER
        end
        return true if sum == 4
        
        sum = 0
        0.upto(3) do |k|
          break if j + k >= COLUMNSIZE
          sum += 1 if @state[i][j + k] == MAXPLAYER
        end
        return true if sum == 4
        
        sum = 0
        0.upto(3) do |k|
          break if (i + k >= ROWSIZE) || (j + k >= COLUMNSIZE)
          sum += 1 if @state[i + k][j + k] == MAXPLAYER
        end
        return true if sum == 4
        
        sum = 0
        0.upto(3) do |k|
          break if (i + k >= ROWSIZE) || (j - k < 0)
          sum += 1 if @state[i + k][j - k] == MAXPLAYER
        end
        return true if sum == 4
      end
    end
    
    false
  end
  
  def minPlayerWon
    0.upto(ROWSIZE - 1) do |i|
      0.upto(COLUMNSIZE - 1) do |j|
        sum = 0
        0.upto(3) do |k|
          break if i + k >= ROWSIZE
          sum += 1 if @state[i + k][j] == MINPLAYER
        end
        return true if sum == 4
        
        sum = 0
        0.upto(3) do |k|
          break if j + k >= COLUMNSIZE
          sum += 1 if @state[i][j + k] == MINPLAYER
        end
        return true if sum == 4
        
        sum = 0
        0.upto(3) do |k|
          break if (i + k >= ROWSIZE) || (j + k >= COLUMNSIZE)
          sum += 1 if @state[i + k][j + k] == MINPLAYER
        end
        return true if sum == 4
        
        sum = 0
        0.upto(3) do |k|
          break if (i + k >= ROWSIZE) || (j - k < 0)
          sum += 1 if @state[i + k][j - k] == MINPLAYER
        end
        return true if sum == 4
      end
    end
    
    false
  end
  
  def isFinalState
    isDraw || maxPlayerWon || minPlayerWon
  end
  
  def makePlay(level)
    @value = Node.alphaBeta(self, level, -99999, 99999, Node::MAXPLAYER)
    @childrens.each do |children|
      puts "Child Valor: #{children.value}"
    end
    @childrens.each do |children|
      if @value == children.value
        return Node.new(children.state)        
      end
    end
    nil
  end
  
  def makePlayMinMax(level)
    @value = Node.minMax(self, level, -99999, 99999, Node::MAXPLAYER)
    puts "Valor: #{@value}"
    @childrens.each do |children|
      puts "Child Valor: #{children.value}"
    end
    @childrens.each do |children|
      if @value == children.value
        return Node.new(children.state)        
      end
    end
    nil
  end
  
  def Node.alphaBeta(node, depth, alpha, beta, player)
    if depth == 0 || node.isFinalState
      node.value = node.getHeuristicValue
      return node.value 
    end
    
    node.generateChildrens(player)
    if player == MAXPLAYER
      node.childrens.each do |children|
        alpha = [alpha, alphaBeta(children, depth - 1, alpha, beta, MINPLAYER)].max
        break if (beta <= alpha)
      end
      node.value = alpha
      return alpha
    else
      node.childrens.each do |children|
        beta = [beta, alphaBeta(children, depth - 1, alpha, beta, MAXPLAYER)].min
        break if (beta <= alpha)
      end
      node.value = beta
      return beta
    end
  end
  
  def Node.minMax(node, depth, alpha, beta, player)
    if depth == 0 || node.isFinalState
      node.value = node.getHeuristicValue
      return node.value 
    end
    
    node.generateChildrens(player)
    if player == MAXPLAYER
      node.childrens.each do |children|
        alpha = [alpha, alphaBeta(children, depth - 1, alpha, beta, MINPLAYER)].max        
      end
      node.value = alpha
      return alpha
    else
      node.childrens.each do |children|
        beta = [beta, alphaBeta(children, depth - 1, alpha, beta, MAXPLAYER)].min        
      end
      node.value = beta
      return beta
    end
  end
  
  def show_table
    (0...ROWSIZE).each do |row| 
      (0...COLUMNSIZE).each do |col|
        val = @state[row][col]
  
        case val
        when 0
          print "|_"
        when MAXPLAYER 
          print "|X"
        when MINPLAYER
          print "|O"
        end
      end
      puts '|'
    end
  end
  
  def putPiece(column, player)
    put = false
    if (column < 0 || column >= COLUMNSIZE)
      return false
    end
    
    (ROWSIZE - 1).downto(0) do |i|
      if (@state[i][column] == 0)
        @state[i][column] = player
        put = true
        break
      end
    end
    put
  end
end