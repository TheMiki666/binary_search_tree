module BinaryTree

  class Tree

    #This class is just used to manage empty arguments 
    #(Like politicians do, hehe!)
    class EmptyClass
      
    end

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

      # Return true if the data is not repeated, so we could insert it
      def append(new_node)
        if (self <=> new_node) == 1
          #Go left
          if @left.nil?
            @left = new_node
            true
          else 
            @left.append(new_node)
          end
        elsif (self <=> new_node) == -1
          #Go right
          if @right.nil?
            @right = new_node
            true
          else 
            @right.append(new_node)
          end
        else
          #data repeated
          false
        end
      end

      #This method is called by Tree#find and Tree#depth
      def search(number, deepness)
        if @data == number
          {:node => self, :deepness => deepness}
        elsif @data > number
          if @left.nil?
            {:node => nil, :deepness => 0}
          else
            @left.search(number, deepness + 1)
          end
        else
          if @right.nil?
            {:node => nil, :deepness => 0}
          else
            @right.search(number, deepness + 1)
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

      def inorder(the_hash, &block)
        @left.inorder(the_hash, &block) if !@left.nil?
        do_stuff_with_data(the_hash, &block)
        @right.inorder(the_hash, &block) if !@right.nil?
        the_hash
      end

      def preorder(the_hash, &block)
        do_stuff_with_data(the_hash, &block)
        @left.preorder(the_hash, &block) if !@left.nil?
        @right.preorder(the_hash, &block) if !@right.nil?
        the_hash
      end

      def postorder(the_hash, &block)
        @left.postorder(the_hash, &block) if !@left.nil?
        @right.postorder(the_hash, &block) if !@right.nil?
        do_stuff_with_data(the_hash, &block)
        the_hash
      end

      def height(previus)
        if self.is_leaf?
          previus
        elsif @left.nil? && !@right.nil?
          @right.height(previus+1)
        elsif !@left.nil? && @right.nil?
          @left.height(previus+1)
        else
          [@left.height(previus+1), @right.height(previus+1)].max
        end
      end

      private

      #This function works with the data when is called by inorder, preorder and postorder
      def do_stuff_with_data(the_hash, &block)
        if block_given?
          @data = yield @data, the_hash[:accumulator]
          the_hash[:accumulator] = @data
        end
        the_hash[:response] << @data
      end

    end #of class Node

    def initialize(array = [])
      build_tree(array)
    end

    # Return true if the data is not repeated, so we could insert it
    def insert(data)
      new_node = Node.new(data)
      if @root.nil?
        @root = new_node
        true
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
        @root.search(number, 1)[:node]
      end
    end

    def depth(number = EmptyClass.new)
      return 0 if number.nil?
      return height if number.instance_of?(EmptyClass)
      number = number.data if number.instance_of?(Node)
      if @root.nil?
        nil
      else
        @root.search(number, 1)[:deepness]
      end 
    end

    # Returns true if the number exits, so the node has been deleted
     #TESTED!
    def delete(number)
      the_hash = find_child_and_parent(number)
      return false if the_hash.nil?
      kill_child(the_hash)
    end

    # It returns the array of data if no block is given,
    # But also the block of new data if block is given
    def level_order(first_data = nil, initial_accumulator = 0)
      fn = first_node(first_data)
      return nil if fn.nil?
      queue =[fn]
      response = []
      accumulator = initial_accumulator
      while queue.length > 0
        node = queue.shift
        if block_given? 
          node.data = yield node.data, accumulator
          accumulator = node.data
        end
        response << node.data
        queue.push(node.left) if !node.left.nil?
        queue.push(node.right) if !node.right.nil?
      end
      #Here we must reorder the tree, because the logical order of the tree must have changed
      rebalance if block_given?
      response
    end

    # It returns the array of data if no block is given,
    # But also the block of new data if block is given
    def inorder(first_data = @root.data, initial_accumulator = 0, &block) 
      fn = first_node(first_data)
      return nil if fn.nil?
      response = []
      result = fn.inorder({:response =>response, :accumulator => initial_accumulator}, &block)
      rebalance if block_given?
      result[:response]
    end

    def preorder(first_data = @root.data, initial_accumulator = 0, &block) 
      fn = first_node(first_data)
      return nil if fn.nil?
      response = []
      result = fn.preorder({:response =>response, :accumulator => initial_accumulator}, &block)
      rebalance if block_given?
      result[:response]
    end

    def postorder(first_data = @root.data, initial_accumulator = 0, &block) 
      fn = first_node(first_data)
      return nil if fn.nil?
      response = []
      result = fn.postorder({:response =>response, :accumulator => initial_accumulator}, &block)
      rebalance if block_given?
      result[:response]
    end

    def rebalance
      # Uncomment next line if you want to know when the tree is rebalancing
      # puts "Rebalancing"
      build_tree(inorder)
    end

    def height(data=EmptyClass.new)
      if data.nil? 
        node = nil
      elsif data.instance_of?(EmptyClass)
        node = @root
      elsif data.instance_of?(Node)
        node = data
      else
        node = find(data)
      end
      return 0 if node.nil?
      node.height(1)
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

    def first_node(first_data)
      if first_data.nil?
        @root
      else
        find(first_data)
      end
    end

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

    #TESTED!
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

    #TESTED!
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
     #TESTED
    def find_next_greater_number(node)
      if node.right.left.nil?
        {:child => node.right, :parent => node, :side => true}
      else 
        find_least_left_node(node.right, node)
      end 
    end
 #TESTED
    def find_least_left_node(node, node_parent)
      if node.left.nil?
        {:child => node, :parent => node_parent, :side => false}
      else
        find_least_left_node(node.left, node)
      end
    end

  end
end