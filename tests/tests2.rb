#TESTS 2
#Testing Tree#delete method

require_relative "lib/tree.rb"

initial_array = []
(1..31).each {|i| initial_array << i*10}
@my_tree = BinaryTree::Tree.new(initial_array)   
@my_tree.pretty_print

puts "Testing Tree#delete"
puts "Deleting leafs: ok"
@my_tree.delete(230)
@my_tree.pretty_print #ok
@my_tree.delete(50)
@my_tree.pretty_print #ok

puts "Deleting one children branches: ok"
@my_tree.delete(60)
@my_tree.pretty_print #ok
@my_tree.delete(220)
@my_tree.pretty_print #ok

puts "Let's prepare a longer one-children branch (left side):"
@my_tree.delete(190)
@my_tree.delete(210)
@my_tree.insert(162)
@my_tree.insert(168)
@my_tree.insert(164)
@my_tree.insert(166)
@my_tree.pretty_print 
@my_tree.delete(200)
@my_tree.pretty_print #ok

puts "Now let's prepare a longer one-children branch (right side):"
@my_tree.insert(350)
@my_tree.insert(320)
@my_tree.insert(340)
@my_tree.insert(330)
@my_tree.insert(335)
@my_tree.pretty_print 
@my_tree.delete(310)
@my_tree.pretty_print 

puts "Now it's time for the hardes case: two children nodes"
@my_tree.delete(100)
@my_tree.pretty_print #ok
@my_tree.delete(140)
@my_tree.pretty_print #ok
@my_tree.delete(300)
@my_tree.pretty_print #ok
puts "Let's see if 80 si replaced by 90..."
@my_tree.delete(80)
@my_tree.pretty_print #ok
puts "Let's see if 160 (the node) is replaced by 162..."
@my_tree.delete(160)
@my_tree.pretty_print #ok
puts "Let's see if 162 (the node) is replaced by 164..."
@my_tree.delete(162)
@my_tree.pretty_print #ok
puts "Let's see if 164 (the node) is replaced by 166..."
puts @my_tree.delete(164)
@my_tree.pretty_print #ok
puts "Let's try to delete a number that doesn't exits..."
puts @my_tree.delete(241)
@my_tree.pretty_print #ok

"Finally, lets try to delete a just one node tree"
@my_tree.clear
@my_tree.insert(666)
@my_tree.insert(669)
@my_tree.pretty_print 
puts @my_tree.delete(666)
@my_tree.pretty_print 
puts @my_tree.delete(666)
puts @my_tree.delete(669)
@my_tree.pretty_print 
puts @my_tree.delete(669)