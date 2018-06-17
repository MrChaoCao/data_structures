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
    elsif current_node.left && current_node.right.nil?
      current_node = current_node.left
    elsif current_node.right && current_node.left.nil?
      current_node = current_node.right
    else
      current_node = replace_parent(current_node)
    end
  end

  def replace_parent(parent_node)
    replacement_node = maximum(parent_node.left)

    if replacement_node.left
      promote_child(parent_node.left)
    end

    replacement_node.left = parent_node.left
    replacement_node.right = parent_node.right

    replacement_node
  end

  def promote_child(child_node)
    if child_node.right
      max = maximum(child_node.right)
    else
      child_node
    end

    child_node.right = max.left
  end

  # helper method for #delete:
  def maximum(current_node = @root)
    if current_node.right.nil?
      current_node
    else
      current_node.right = maximum(current_node.right)
    end
  end

  def depth(tree_node = @root)
    if tree_node.nil?
      -1
    else
      left_depth = depth(tree_node.left)
      right_depth = depth(tree_node.right)

      left_depth > right_depth ? left_depth + 1 : right_depth + 1
    end
  end

  def is_balanced?(tree_node = @root)
    return true if tree_node.nil?
    left_depth = depth(tree_node.left)
    right_depth = depth(tree_node.right)
    return false if (left_depth - right_depth).abs > 1
    return true if is_balanced?(tree_node.left) && is_balanced?(tree_node.right)
    false
  end

  def in_order_traversal(tree_node = @root, arr = [])
    if tree_node.left
      in_order_traversal(tree_node.left, arr)
    end

    arr << tree_node.value

    if tree_node.right
      in_order_traversal(tree_node.right, arr)
    end

    arr
  end
  private
  # optional helper methods go here:

end
