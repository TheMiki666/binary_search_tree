module BinaryTree

  class Tree

    class Node 
      include Comparable

      attr_accessor :data, :left, :right

      def initialize(data)
          @data = data
          @left = nil
          @right = nil
      end

      def <=>(other)
        @data <=> other.data
      end

      def append(new_node)
        if (self <=> new_node) == 1
          #Go left
          if @left.nil?
            @left = new_node
          else 
            @left.append(new_node)
          end
        else
          #Go right
          if @right.nil?
            @right = new_node
          else 
            @right.append(new_node)
          end
        end

        def find(number)
          if @data == number
            self
          elsif @data > number
            if @left.nil?
              nil
            else
              @left.find(number)
            end
          else
            if @right.nil?
              nil
            else
              @right.find(number)
            end
          end
        end

        # This function is used by Tree#find_child_and_parent
        # Returns a hash with three elements
        # "Child" is the node with the number we try to find;
        # "Parent" is the node parent of the child. 
        # "Side" is true if the child is attached to the right side of the parent, and false if it's the left side
        # Returns nil instead of an array if the number is not found
        def find_child_and_parent(number)
          # It's impossible that this node is the child
          if @data < number
            if @right.nil?
              nil
            elsif @right.data == number
              { :child => @right, :parent => self, :side => true }
            else
              @right.find_child_and_parent(number)
            end
          else
            if @left.nil?
              nil
            elsif @left.data == number
              { :child => @left, :parent => self, :side => false }
            else
              @left.find_child_and_parent(number)
            end
          end
        end

        # Return true if the node is a leaf (has no children), false if it is a branch
        def is_leaf?
          return @left.nil? && @right.nil?
        end

      end
    end #of class Node

    def initialize(array = [])
      build_tree(array)
    end

    def insert(data)
      new_node = Node.new(data)
      if @root.nil?
        @root = new_node
      else
        @root.append(new_node)
      end
    end

    def build_tree(array)
      array.uniq!
      array.sort!
      clear
      insert_array(array)
      return @root
    end

    def clear
      @root = nil
    end

    #returns the node that has the number
    def find(number)
      if @root.nil?
        nil
      else
        @root.find(number)
      end
    end

    # Returns true if the number exits, so the node has been deleted
     #!NOT TESTED
    def delete(number)
      the_hash = find_child_and_parent(number)
      return false if the_hash.nil?
      kill_child(the_hash)
    end

    def pretty_print(node = @root, prefix = '', is_left = true)
      if @root.nil?
        puts "(Empty tree)"
        return
      end
      pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
      puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
      pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
    end

    def ugly_print
      p self
    end

    private

    # TESTED!
    # Returns a hash with three elements
    # "Child" is the node with the number we try to find; 
    # "Parent" is the node parent of the child. If it's nil but the child isn't, that means that the child is the root
    # "Side" is true if the child is attached to the right side of the parent, and false if it's the left side
    # Returns nil instead of an array if the number is not found
    def find_child_and_parent(number)
      if @root.nil?
        nil
      elsif @root.data == number
        { :child => @root, :parent => nil, :side => false }
      else 
        @root.find_child_and_parent(number)
      end
    end

    #!NOT TESTED
    def kill_child(the_hash)
      victim = the_hash[:child] #victim means: node to dissapear
      parent = the_hash[:parent]
      right_side = the_hash[:side]
      if victim.is_leaf?
        #case 1: the victim has no children
        #We only need to erase it
        replace_child(parent, right_side, nil)
      elsif victim.left.nil? && !victim.right.nil?
        #case 2.a: the victim has just one children (on the right)
        #We only need to replace the victim for victim's child
        replace_child(parent, right_side, victim.right)
      elsif !victim.left.nil? && victim.right.nil?
        #case 2.b: on the left
        replace_child(parent, right_side, victim.left)
      else
        #case 3: the victim has two children
        #We need to find the node with the next greater number,
        #substitute victims data for this number, 
        #and delete the next greater number
        new_hash = find_next_greater_number(victim)
        victim.data = new_hash[:child].data
        kill_child(new_hash)
      end
      true
    end

    #!NOT TESTED
    def replace_child(parent, right_side, replacement)
      if parent.nil?
        @root = replacement
      elsif right_side
        parent.right = replacement
      else
        parent.left = replacement
      end
    end 

    def insert_array(array)
      l = array.length 
      if l == 0
        #do nothing
      elsif l == 1
        insert(array[0])
      else
        a = array.slice!(0,l/2)  #[1,2,3,4,5] -> [1,2] [3,4,5]
        b = array.slice!(0,1)    #[3,4,5] -> [3] [4,5]
        insert(b[0])             #[3]
        insert_array(a)          #[1,2]
        insert_array(array)      #[4,5]
      end
    end
    
    #returns a hash with the node with next greater number, and its parent
     #!NOT TESTED
    def find_next_greater_number(node)
      if node.right.left.nil?
        {:child => node.right, :parent => node, :side => true}
      else 
        find_least_left_node(node.right, node)
      end 
    end
 #!NOT TESTED
    def find_least_left_node(node, node_parent)
      if node.left.nil?
        {:child => node, :parent => node_parent, :side => false}
      else
        find_least_left_node(node.left, node)
      end
    end

  end
end