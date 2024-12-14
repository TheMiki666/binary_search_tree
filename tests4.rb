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
