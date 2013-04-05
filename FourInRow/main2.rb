require_relative 'node'

print "Introduce tu nombre: "
name = gets
puts "Bienvenido #{name}!, Quien quieres que empiece a jugar (1 = Yo, 2 = Maquina): "
resp = gets.to_i

node = Node.new

if resp == 1
  node.show_table
  puts "Introduce la columna: "
  j = gets.to_i
  node.putPiece(j, Node::MINPLAYER)
  node.show_table
end

while (!node.isFinalState)
  puts "Ahora yo hago mi jugada, espera...."
  node = node.makePlay 8
  puts "Esta es mi jugada ;)"
  node.show_table
  
  break if (node.maxPlayerWon || node.isDraw)
  
  puts "Tu turno"
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
  puts "Perdi :( gg)"
end
