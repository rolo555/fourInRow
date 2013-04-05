require_relative 'node'

def time_diff(start, finish)
  (finish - start) * 1000.0
end

print "Introduce tu nombre: "
name = gets.delete("\n")
puts "Bienvenido #{name}!, Quien quieres que empiece a jugar (1 = Yo, 2 = Maquina): "
resp = gets.to_i
puts "Quiere usar (1)Min-Max o (2)alfa-beta"
algo = gets.to_i
puts "Que heuristica desea usar? (1.- La de la clase, 2.- La super heuristica)"
heu = gets.to_i
puts "Que nivel desea jugar? (1.- facil, 2.- medio, 3.- dificil, 4.- Super dificil)"
level = gets.to_i

if (level == 1)
  level = 3
elsif (level == 2)
  level = 5
elsif (level == 3)
  level = 7
else
  level = 8
end

node = Node.new

if resp == 1
  node.show_table
  puts "Introduce la columna: "
  j = gets.to_i
  node.putPiece(j, Node::MINPLAYER)
  node.show_table
end

while (!node.isFinalState)
  tstart = Time.now
  puts "Ahora yo hago mi jugada, espera...."
  if (algo == 1)
    if (heu == 1)
      puts "Usando Minimax, y la heuristica de la clase"
      node = node.makePlayMinMax2 level
    else
      puts "Usando Minimax, y la super heuristica"
      node = node.makePlayMinMax level 
    end
  else
    if (heu == 1)
      puts "Usando Alfa-Beta, y la heuristica de la clase"
      node = node.makePlay2 level
    else
      puts "Usando Alfa-Beta, y la super heuristica"
      node = node.makePlay level
    end
  end
  puts("Tiempo que tarde: #{time_diff(tstart, Time.now)}ms.")
  puts "Esta es mi jugada ;)"
  node.show_table
  
  break if (node.maxPlayerWon || node.isDraw)
  
  puts "Tu turno #{name}"
  puts "Introduce la columna: "
  j = gets.to_i
  node.putPiece(j, Node::MINPLAYER)
  node.show_table
end

if node.maxPlayerWon
  puts "Ganeee jahajajajjaja :D"
elsif node.isDraw
  puts "Empatamos :) gg"
else
  puts "Perdi :( gg"
end
