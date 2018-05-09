class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = []
    @prc ||= Proc.new {|a,b| a < b}
  end

  def count
    @store.length
  end

  def extract
  end

  def peek
  end

  def push(val)
  end

  public
  def self.child_indices(len, parent_index)
    children = []

    first_child = (parent_index * 2) + 1
    second_child = first_child + 1

    children << first_child if first_child < len
    children << second_child if second_child < len

    children
  end

  def self.parent_index(child_index)
    raise 'root has no parent' if child_index == 0
    (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    children = child_indices(len, parent_idx)
    prc ||= Proc.new {|a,b| a < b}
    if prc.call(array[parent_idx], array[children.last])
      array[parent_idx], array[children.last] = array[children.last], array[parent_idx]
      heapify_down(array, children.last, len = array.length, &prc)
    end
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    return array if child_idx == 0
    parent_idx = parent_index(child_idx)
    prc ||= Proc.new {|a,b| a < b}

    if prc.call(array[child_idx], array[parent_idx])
      array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
      heapify_up(array, parent_idx, len = array.length, &prc)
    end
    
    array
  end
end
