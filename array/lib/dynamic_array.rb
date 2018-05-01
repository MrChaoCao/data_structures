require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @length = 0
    @capacity = 8
    @store = StaticArray.new(@capacity)
  end

  # O(1)
  def [](index)
    raise "index out of bounds" if index >= @length
    @store[index]
  end

  # O(1)
  def []=(index, value)
    @store[index] = value
  end

  # O(1)
  def pop
    raise "index out of bounds" if @length == 0
    @length -= 1
    @store[@length]
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! if @length == @capacity
    @store[@length] = val
    @length += 1
  end

  # O(n): has to shift over all the elements.
  def shift
    raise "index out of bounds" if @length == 0
    @length -= 1
    shifted = @store[0]
    @length.times do |idx|
      @store[idx] = @store[idx + 1]
    end
    shifted
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    resize! if @length == @capacity
    @length.downto(1) do |idx|
      @store[idx] = @store[idx - 1]
    end
    @store[0] = val
    @length += 1
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    @capacity *= 2
    temp_store = StaticArray.new(@capacity)
    @length.times do |idx|
      temp_store[idx] = @store[idx]
    end
    @store = temp_store
  end
end
