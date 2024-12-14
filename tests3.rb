#TESTS 2
#Testing Tree#lever_order, #rebalance #inorder, #preorder and #postorder
#

require_relative "lib/tree.rb"

initial_array = []
(1..15).each {|i| initial_array << i}
@my_tree = BinaryTree::Tree.new(initial_array)   
@my_tree.pretty_print

puts "Testing #level_order"
puts "Also testing #rebalance intrinsically"
p @my_tree.level_order #ok
p @my_tree.level_order(4) #ok
p @my_tree.level_order(3) #ok
p @my_tree.level_order(18) #ok
p @my_tree.level_order {|x| 2*x} #ok
@my_tree.pretty_print
p @my_tree.level_order(8) {|x| 10*x} #ok
@my_tree.pretty_print
p @my_tree.level_order(50) {|x| 10*x} #ok
@my_tree.pretty_print
p @my_tree.level_order {|x| -1*x} #ok
@my_tree.pretty_print
p @my_tree.level_order {|x| -1*x} #ok
@my_tree.pretty_print
p @my_tree.level_order {666} #ok
@my_tree.pretty_print
p @my_tree.level_order {"hello"} #ok
@my_tree.pretty_print

puts "Testing opperations with accummulator"
initial_array = []
(1..7).each {|i| initial_array << i}
@my_tree = BinaryTree::Tree.new(initial_array)   
@my_tree.pretty_print
p @my_tree.level_order {|x, acc| x+acc} #ok
@my_tree.pretty_print
p @my_tree.level_order(6,100) {|x, acc| x+acc} #ok
@my_tree.pretty_print

puts "Testing rebalance"
@my_tree.clear
p @my_tree.level_order #ok
(1..24).each {|i| @my_tree.insert(i)}
@my_tree.pretty_print
@my_tree.rebalance
@my_tree.pretty_print #ok

puts "Testing inorder"
p @my_tree.inorder #ok
@my_tree.pretty_print 
p @my_tree.inorder(4) #ok
p @my_tree.inorder(9) #ok
p @my_tree.inorder(20) #ok
p @my_tree.inorder(19) #ok
p @my_tree.inorder(666) #ok

p @my_tree.inorder{|x| 10*x} #ok
@my_tree.pretty_print 
p @my_tree.inorder(4){|x| x/5} #ok
@my_tree.pretty_print 
p @my_tree.inorder(40){|x| x/10} #ok
@my_tree.pretty_print 
p @my_tree.inorder(190){|x| x/10} #ok
@my_tree.pretty_print 

puts "Testing opperations with accummulator"
initial_array = []
(1..7).each {|i| initial_array << i}
@my_tree = BinaryTree::Tree.new(initial_array)   
@my_tree.pretty_print
p @my_tree.inorder {|x, acc| x+acc} #ok
@my_tree.pretty_print
p @my_tree.inorder(3,100) {|x, acc| x+acc} #ok
@my_tree.pretty_print

