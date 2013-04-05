

#@@table = Array.new(6) { Array.new(7){ 0 }}

def show_table(table)
  (0..5).each do |row| 
    (0..6).each do |col|
      val = table[row][col]
      case val
      when 0
        print "|_"
      when 1 
        print "|X"
      when -1
        print "|O"
      end
    end
    puts '|'
  end
end

#valida si no existe una ficha diferente en medio de 
#la fila a evaluar

def valid_row?(row, col, start_row, table)
  pos_val = table[row][col]
  return false if pos_val == 0
  if(start_row <= 3)
    (start_row .. (start_row + 3)).each do |option_start|
      return false if (( option_start > 6) or (table[row][option_start] == pos_val * -1 ))
    end
  else
    ((start_row - 3) .. start_row).each do |option_start|
      return false if ((option_start < 0) or (table[row][option_start] == pos_val * -1))
    end
  end
  true
end

def valid_col?(row, col, start_col, table)
  pos_val = table[row][col]
  return false if pos_val == 0
  if(start_col < 3)
    (start_col .. (start_col + 3)).each do |option_start|
      return false if ( (option_start > 5) or (table[option_start][col] ==  pos_val * -1))
    end
  else
    ((start_col - 3) .. start_col).each do |option_start|
      return false if ( (option_start < 0) or (table[option_start][col] == pos_val * -1))
    end
  end
  true
end

def valid_right_diagonal?(row, col, start_row, start_col, table)
  pos_val = table[row][col]
  return false if pos_val == 0
  3.times do
    return false if ((start_row < 0 ) or (start_col > 6) or (start_row > 5) or (start_col < 0) or (table[start_row][start_col] == pos_val * -1))
    start_row -= 1
    start_col += 1
  end
  true
end

def valid_left_diagonal?(row,col,start_row,start_col, table)
  pos_val=table[row][col]
  return false if pos_val==0
  3.times do
    return false if ((start_row < 0 ) or (start_col < 0) or  (start_row > 5) or (start_col > 6) or (table[start_row][start_col] == pos_val * -1))
    start_col-=1
    start_row-=1
  end
end

def get_start_diagonal_left(row,col, table)
  resp = []
  new_row = row
  new_col = col
  4.times do
    resp << [new_row, new_col] if valid_left_diagonal?(row,col,new_row,new_col, table)
    new_row+=1
    new_col+=1
  end
  resp
end

#encuentra las posibles columnas para formar
#cuantro en raya

def get_start_row(row, col, table)
  resp = []
  if(col <= 3)
    (0..col).each  do |option|
      resp << option if(valid_row?(row, col, option, table))
    end
  else
    (col...7).each do |option|
      resp << option if(valid_row?(row, col, option, table))
    end
  end
  resp 
end

def get_start_col(row, col, table)
  resp = []
  if(row < 3)
    (0..row).each do |option|
      resp << option if(valid_col?(row, col, option, table))
    end
  else
    (row..5).each do |option|
      resp << option if(valid_col?(row, col, option, table))
    end
  end
  resp
end

def get_start_right_diagonal(row, col, table)
  resp =[]
  aux_row = row
  aux_col = col
  4.times do
    resp << [aux_row, aux_col] if (valid_right_diagonal?(row, col, aux_row, aux_col, table))
    aux_row += 1
    aux_col -= 1
  end
  resp
end

def best_option_diagonal_left(row,col, table)

  options = get_start_diagonal_left(row, col, table)
  return 0 if options.empty?
  number_of_best_moves = 1
  best_move = 99
  options.each do |option|
    moves = 0
    new_row=option[0]
    new_col=option[1]
    4.times do
      moves+=count_number_of_moves(new_row,new_col, table)
      new_row-=1
      new_col-=1
    end
    number_of_best_moves += 1 if moves == best_move
    number_of_best_moves = 1 if moves < best_move
    best_move = moves if moves < best_move
  end
  best_move * number_of_best_moves
end

def count_number_of_moves(row, col, table)
  moves = 0
  (row...6).each do |new_row|
    moves += 1 if table[new_row][col] == 0
  end 
  moves
end

#regers la multiplicacion de mejor numero de movidas
#por el numero de veces que se repiten
def best_option_row(row, col, table)
  options = get_start_row(row, col, table)
  return 0 if options.empty? 
  number_of_best_moves = 1
  best_move = 99
  options.each do |option|
    moves = 0
    if(option <= 3)
      (option..(option + 3)).each do |option_col|
        moves += count_number_of_moves(row, option_col, table)
      end
    else
      ((option - 3)..option).each do |option_col|
        moves += count_number_of_moves(row, option_col, table)
      end
    end
    number_of_best_moves += 1 if moves == best_move
    number_of_best_moves = 1 if moves < best_move
    best_move = moves if moves < best_move
  end

  number_of_best_moves * best_move
end

def best_option_col(row, col, table)
  options = get_start_col(row, col, table)
  return 0 if options.empty? 
  number_of_best_moves = 1
  best_move = 99
  options.each do |option|
    moves = 0
    moves += count_number_of_moves((option - 3), col, table)
    number_of_best_moves += 1 if moves == best_move
    number_of_best_moves = 1 if moves < best_move
    best_move = moves if moves < best_move
  end
  number_of_best_moves * best_move
end

def best_option_right_diagonal(row, col, table)
  options = get_start_right_diagonal(row, col, table)
  return 0 if options.empty?
  number_of_best_moves = 1
  best_move = 99
  options.each do |option|
    aux_row = option[0]
    aux_col = option[1]
    moves = 0
    3.times do
      aux_row -= 1
      aux_col += 1
      moves += count_number_of_moves(aux_row, aux_col, table)
    end
    number_of_best_moves += 1 if moves == best_move
    number_of_best_moves = 1 if moves < best_move
    best_move = moves if moves < best_move
  end
  number_of_best_moves * best_move
end


#options = get_start_row(5, 3)

#@@table[3][3] = 1
#@@table[3][4] = 1
#@@table[4][3] = 1
#@@table[4][4] = -1
#@@table[5][1] = 1
#@@table[5][2] = 1
#@@table[5][3] = -1
#@@table[5][4] = -1
#@@table[5][5] = -1

#@@row = 5
#@@col = 3

#puts "para [#{@@row}, #{@@col}]:"
#puts "mejor fila: #{best_option_row(@@row, @@col)}"
#puts "mejor columna: #{best_option_col(@@row, @@col)}"
#puts "mejor digaonal derecha: #{best_option_right_diagonal(@@row, @@col)}"
#puts "mejor digaonal izquierda: #{best_option_diagonal_left(@@row, @@col)}"

def heuristica(table)
  p1_row = [0,0]
  p1_col = []
  p1_dig_righ = []
  p1_dig_left = []
  p2_row = []
  p2_col = []
  p2_dig_righ = []
  p2_dig_left = []
  table.each_with_index do |row, i|
    row.each_with_index do |node, j|
      if(node != 0)
        if(node == 1)
          p1_row << best_option_row(i, j, table)
          p1_col << best_option_col(i, j, table)
          p1_dig_righ << best_option_right_diagonal(i, j, table)
          p1_dig_left << best_option_diagonal_left(i, j, table)
        else
          p2_row << best_option_row(i, j, table)
          p2_col << best_option_col(i, j, table)
          p2_dig_righ << best_option_right_diagonal(i, j, table)
          p2_dig_left << best_option_diagonal_left(i, j, table)
        end 
      end
    end
  end

  p1 = p1_row | p1_col | p1_dig_righ | p1_dig_left
  p1.delete(0)
  p1_min_value = p1.min
  p2 = p2_row | p2_col | p2_dig_righ | p2_dig_left
  p2.delete(0)
  p2_min_value = p2.min
  #  puts "p1 - p2: #{p1_min_value} - #{p2_min_value} = #{p1_min_value - p2_min_value}"
  p1_min_value - p2_min_value
end

#puts heuristica(@@table)
#show_table
