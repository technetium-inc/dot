
class LexerPosition
	attr_accessor :position

  def initialize(position=0)
    @position = position
  end

  def increment(increment_by=1)
    @position += 1
  end

  def decrement(decrement_by=1)
    increment(-decrement_by)
  end

  def current_character(data)
    if data.length == @position
      return nil 
    else
      return data[@position]
    end
  end
end