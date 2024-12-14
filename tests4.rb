#TESTS 4
#Testing Tree#height, depth and balanced?

require_relative "lib/tree.rb"

"Testing height"
@my_tree = BinaryTree::Tree.new([]) 
p @my_tree.height #ok
@my_tree.insert(1)
p @my_tree.height #ok
p @my_tree.height(2)
(2..128).each { |i| @my_tree.insert(i)}
p @my_tree.height #ok
p @my_tree.height(2) #ok
p @my_tree.height(128) #ok
p @my_tree.height(127) #ok
p @my_tree.height(64) #ok
p @my_tree.height(29) #ok
@my_tree.rebalance
@my_tree.pretty_print
p @my_tree.height(64) #ok
p @my_tree.height(5) #ok
p @my_tree.height(65) #ok
p @my_tree.height(97) #ok 
p @my_tree.height(33) #ok
p @my_tree.height #ok
@my_tree.delete(1)
p @my_tree.height #ok
@my_tree.delete(5)
p @my_tree.height #ok

"Testing find(refactored) and depth"
@my_tree.pretty_print
p @my_tree.find(10) #ok
p @my_tree.depth(10) #ok
p @my_tree.find(21) #ok
p @my_tree.depth(21) #ok
p @my_tree.find(21) #ok
p @my_tree.depth(65) #ok
p @my_tree.find(666) #ok
p @my_tree.depth(666) #ok
p @my_tree.depth #ok

puts "Retesting height and depth (nodes, nil and no arguments)"
my_node = @my_tree.find(9)
p @my_tree.height(my_node) #ok
p @my_tree.height(nil) #ok
p @my_tree.height #ok
my_node = @my_tree.find(49)
p @my_tree.depth(my_node) #ok
p @my_tree.depth(nil) #ok
p @my_tree.depth #ok
