require_relative "lib/tree.rb"

def insert_and_print(number)
  @my_tree.insert(number)
  @my_tree.pretty_print
  puts "-----"
end

puts "Testing tree creation"
initial_array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
@my_tree = BinaryTree::Tree.new(initial_array)
@my_tree.pretty_print
@my_tree.ugly_print
puts "--------"

puts "Testing if its corrctly balanced when creating a new tree"
5.times do
  random_array = []
  (10 + rand(20)).times {random_array << rand(100)}
  p random_array.uniq!
  @my_tree.build_tree(random_array)
  @my_tree.pretty_print
end
puts "--------"

puts "Testing clear function"
@my_tree.clear
@my_tree.pretty_print
@my_tree.ugly_print
puts "--------"

puts "Testing inserting one by one"
(1..25).each {|i| insert_and_print(i)}
@my_tree.clear
(1..25).each {|i| insert_and_print(26-i)}
@my_tree.clear
(1..25).each {|i| insert_and_print(rand(100))}
@my_tree.clear
puts "--------"





