

@@table = Array.new(6) { Array.new(7){ 0 }}

def show_table
  (0..5).each do |row| 
    (0..6).each do |col|
      val = @@table[row][col]

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

#encuentra las posibles columnas para formar
#cuantro en raya

def get_start_row(col)
  resp = Array.new
  if(col <= 3)
    (0..col).each  do |option|
      resp << option
    end
  else
    (col..6).each do |option|
      resp << option
    end
  end
  return resp 
end

#valida si no existe una ficha diferente en medio de 
#la fila a evaluar

def valid_row?(row, col, start_row)
  pos_val = @@table[row][col]
  if(start_row <= 3)
    (start_row .. (start_row + 3)).each do |option_start|
      return false if @@table[row][option_start] == pos_val * -1
    end
  else
    ((start_row - 3) .. start_row).each do |option_start|
      puts option_start
      return false if @@table[row][option_start] == pos_val * -1
    end
  end
  true
end

def count_number_of_moves(row, col)
  moves = 0
  (row..5).each do |new_row|
    moves += 1 if @@table[new_row][col] == 0
  end 
  moves
end


#regers la multiplicacion de mejor numero de movidas
#por el numero de veces que se repiten
def best_option_row(row, col)
  options = get_start_row(col)
  number_of_best_moves = 1
  best_move = 99
  options.each do |option|
    moves = 0
    (option..(option + 3)).each do |option_col|
      #      puts 'row: ' + row.to_s + ' col: ' + option_col.to_s + ' n_moves: ' + count_number_of_moves(row, option_col).to_s
      moves += count_number_of_moves(row, option_col)
      #      break if moves > best_move
    end
    puts "moves: #{moves}"
    number_of_best_moves += 1 if moves == best_move
    number_of_best_moves = 1 if moves < best_move
    best_move = moves if moves <= best_move
  end
  #  puts n_best_moves
  #  puts best_move
  number_of_best_moves * best_move
end

options = get_start_row(3)

@@table[3][3] = 1
@@table[3][4] = 1
@@table[4][3] = 1
@@table[4][4] = -1
@@table[5][1] = 1
@@table[5][2] = 1
@@table[5][3] = -1
@@table[5][4] = -1
@@table[5][5] = -1

#puts valid_row?(5,6,6)

puts best_option_row(3,3)
show_table

