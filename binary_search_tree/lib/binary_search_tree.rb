# There are many ways to implement these methods, feel free to add arguments
# to methods as you see fit, or to create helper methods.

class BinarySearchTree
  attr_accessor :root

  def initialize
    @root = nil
  end

  def insert(value, current_node = @root)
    @root = BSTNode.new(value) if @root.nil?
    return BSTNode.new(value) if current_node.nil?

    if value < current_node.value
      current_node.left = insert(value, current_node.left)
    else
      current_node.right = insert(value, current_node.right)
    end

    current_node
  end

  def find(value, current_node = @root)
    return nil if current_node.nil?
    return current_node if value == current_node.value

    if value < current_node.value
      current_node.left = find(value, current_node.left)
    else
      current_node.right = find(value, current_node.right)
    end
  end

  def delete(value, current_node = @root)
    return nil if current_node.nil?
    if value == current_node.value
      current_node = delete_helper(current_node)
    elsif value < current_node.value
      current_node.left = delete(value, current_node.left)
    else
      current_node.right = delete(value, current_node.right)
    end

    current_node
  end

  def delete_helper(current_node)
    if current_node == @root
      @root = nil
    elsif current_node.left.nil? && current_node.right.nil?
      current_node = nil
    end
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    if tree_node.right.nil?
      tree_node
    else
      tree_node.right = maximum(tree_node.right)
    end
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
