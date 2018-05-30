class BSTNode
  attr_reader :value
  attr_accessor :left, :right

  def initialize(value)
    @parent = nil
    @value = value
    @left = nil
    @right = nil
  end
end
