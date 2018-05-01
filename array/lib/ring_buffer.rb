require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @length = 0
    @capacity = 8
    @start = 0
    @store = StaticArray.new(@capacity)
  end

  # O(1)
  def [](index)
    check_index(index)
    target = (@start + index) % @capacity
    @store[target]
  end

  # O(1)
  def []=(index, val)
    check_index(index)
    target = (@start + index) % @capacity
    @store[target] = val
  end

  # O(1)
  def pop
    raise "index out of bounds" if @length == 0
    popped = @store[(@start + @length) % capacity - 1]
    @length -= 1
    popped
  end

  # O(1) ammortized
  def push(val)
    resize! if @length == capacity
    @store[(@start + length) % capacity] = val
    @length += 1
  end

  # O(1)
  def shift
    raise "index out of bounds" if @length == 0
    shifted = @store[@start]
    @start = (@start + 1) % @capacity
    @length -= 1
    shifted
  end

  # O(1) ammortized
  def unshift(val)
    resize! if @length == capacity
    @start = (@start - 1) % @capacity
    @length += 1
    @store[@start] = val
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    if index >= @length
      raise "index out of bounds"
    end
  end

  def resize!
    new_capacity = @capacity * 2
    temp_store = StaticArray.new(new_capacity)
    @length.times do |idx|
      temp_store[idx] = @store[(@start + idx) % capacity]
    end
    @start = 0
    @capacity = new_capacity
    @store = temp_store
  end
end
