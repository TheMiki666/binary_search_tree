#Official driver script

require_relative "lib/tree.rb"

my_array = (Array.new(15) { rand(1..100) })
my_tree = BinaryTree::Tree.new(my_array) 
my_tree.pretty_print
puts "Balanced?: #{my_tree.balanced?}"
puts "Level order:"
p my_tree.level_order
puts "Preorder:"
p my_tree.preorder
puts "Postorder:"
p my_tree.postorder
puts "In order:"
p my_tree.inorder
my_tree.insert(105)
my_tree.insert(110)
my_tree.pretty_print
puts "Balanced?: #{my_tree.balanced?}"
my_tree.rebalance
my_tree.pretty_print
puts "Balanced?: #{my_tree.balanced?}"
puts "Level order:"
p my_tree.level_order
puts "Preorder:"
p my_tree.preorder
puts "Postorder:"
p my_tree.postorder
puts "In order:"
p my_tree.inorder
