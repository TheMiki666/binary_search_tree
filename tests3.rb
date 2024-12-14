#TESTS 2
#Testing Tree#lever_order
#

require_relative "lib/tree.rb"

initial_array = []
(1..15).each {|i| initial_array << i}
@my_tree = BinaryTree::Tree.new(initial_array)   
@my_tree.pretty_print

puts "Testing #level_order"
puts "Alse testing #rebalance intrinsically"
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

#Testing opperations with accummulator
initial_array = []
(1..7).each {|i| initial_array << i}
@my_tree = BinaryTree::Tree.new(initial_array)   
@my_tree.pretty_print
p @my_tree.level_order {|x, acc| x+acc} #ok
@my_tree.pretty_print
p @my_tree.level_order(6,100) {|x, acc| x+acc} #ok
@my_tree.pretty_print