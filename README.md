# binary_search_tree
Binary Search Tree exercise from The Odin Project

https://www.theodinproject.com/lessons/ruby-binary-search-trees


You have learned about binary search trees, where you take a group of data items and turn them into a tree full of nodes, with each left node being “lower” than each right node. The tree starts with the “root node” and any node with no children is called a “leaf node”. You have also learned about tree traversal algorithms like breadth-first and depth-first.

Now, let’s take a look at balanced binary search trees (BST). A BST allows fast operations for lookup, insertion, and deletion of data items.

You’ll build a balanced BST in this assignment. Do not use duplicate values because they make it more complicated and result in trees that are much harder to balance. Therefore, be sure to always remove duplicate values or check for an existing value before inserting.

# TESTING

Puts the tests in main directory if you want to try them

# COMMENTARIES

 * #level_order, #preorder, #inorder and #postorder has new features:
    - They can start in any node (you have to insert the corresponding data as an argument)
    - Thet return an array with the results, even when you have given a block
    - They allow to operate with an accumulator, passed as a second argument in the block (you can also set the initial value of the accumulator, passing it
    as a second parameter of the method)
    - After the operation, the tree is reorder and rebalanced (other wise, the logical order of the tree would became altered)

* Methods #depth and #height can accept a node, a data, nil and even nothing (no arguments). 
    - With no arguments,  it gives the maximum depth (or height) of the tree
    - If argument is nil, both methods return 0
    - If argument is data, it tries to find the correspondet node; if it doesn't exists, return 0