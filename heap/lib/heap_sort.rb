require_relative "heap"

class Array
  def heap_sort!
    self.count.times do |i|
      BinaryMinHeap.heapify_up(self, i, i)
    end

    self.count.times do |i|
      self[0], self[count - 1 - i] = self[count - 1 - i], self[0]
      BinaryMinHeap.heapify_down(self, 0, count - 1 - i)
    end

    self.reverse!
  end
end
