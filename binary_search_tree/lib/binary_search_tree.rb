# There are many ways to implement these methods, feel free to add arguments
# to methods as you see fit, or to create helper methods.

class BinarySearchTree
  attr_accessor :root

  def initialize
    @root = nil
  end

  def insert(value)
    if @root.nil?
      @root = BSTNode.new(value)
    else
      insert_helper(@root, value)
    end
  end

  def insert_helper(node, value)
    return BSTNode.new(value) if node.nil?

    if value < node.value
      node.left = insert_helper(node.left, value)
    else
      node.right = insert_helper(node.right, value)
    end

    node
  end

  def find(value, tree_node = @root)
    return nil unless tree_node
    if value == tree_node.value
      tree_node
    elsif tree_node.value > value
      find(value, tree_node.left)
    else
      find(value, tree_node.right)
    end
  end

  def delete(value)
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
  end

  def depth(tree_node = @root)
  end

  def is_balanced?(tree_node = @root)
  end

  def in_order_traversal(tree_node = @root, arr = [])
  end


  private
  # optional helper methods go here:

end
