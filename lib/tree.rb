module BinaryTree

  class Tree

    class Node 
      include Comparable

      attr_reader :data, :left, :right

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
      array.sort!
      clear
      insert_array(array)
    end

    def clear
      @root = nil
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

  end
end