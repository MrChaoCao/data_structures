class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = []
    @prc ||= Proc.new {|a,b| a <=> b}
  end

  def count
    @store.length
  end

  def extract
    @store[0], @store[-1] = @store[-1], @store[0]
    extracted = @store.pop
    BinaryMinHeap.heapify_down(@store, 0, len = @store.length, &prc)
    extracted
  end

  def peek
    @store.first
  end

  def push(val)
    @store.push(val)
    BinaryMinHeap.heapify_up(@store, @store.length - 1, len = @store.length, &prc)
  end

  public
  def self.child_indices(len, parent_index)
    double = 2 * parent_index
    children = []

    children << double + 1 unless double + 1 > len - 1
    children << double + 2 unless double + 2 > len - 1

    children
  end

  def self.parent_index(child_index)
    raise 'root has no parent' if child_index == 0
    (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    children = child_indices(len, parent_idx)
    return array if children.empty?
    prc ||= Proc.new {|a,b| a <=> b}

    if children.length == 2
      child_idx = prc.call(array[children.first], array[children.last]) < 0 ? children.first : children.last
    else
      child_idx = children.first
    end

    if prc.call(array[child_idx], array[parent_idx]) < 0
      array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
    end

    heapify_down(array, child_idx, len, &prc)
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    return array if child_idx == 0
    parent_idx = parent_index(child_idx)
    prc ||= Proc.new {|a,b| a <=> b}

    if prc.call(array[child_idx], array[parent_idx]) < 0
      array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
      heapify_up(array, parent_idx, len = array.length, &prc)
    end

    array
  end
end
