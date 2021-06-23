require_relative "./position.rb"

class LexicalAnalyser

  def initialize(data)
    @data = data
    @line_number = 1
    @position = LexerPosition.new()
  end

  def tokenise()
    print(@data)
  end
end