require_relative "./position.rb"

NUMBERS = Array(0..9).map do |number|
  String(number)
end

class LexerToken
  def initialize(name, token_type)
    @name = name
    @token_type = token_type
  end
end

class LexicalAnalyser

  def initialize(data)
    @data = data
    @line_number = 1
    @position = LexerPosition.new()
    @tokens = []
  end

  def string_to_integer_or_nil(string)
    begin
      return Integer(string)
    rescue ArgumentError
      return nil 
    end
  end

  def tokenise()
    character = @position.current_character(@data)
    while character != nil do
      case character
      when "\t"
        token = LexerToken.new(character, "TAB")
        @tokens.push(token)
      when "\n"
        @tokens.push(LexerToken.new(character, "NEWLINE"))
      else
        if NUMBERS.include?(character)
          token = LexerToken.new(character, "NUMBER")
          @tokens.push(token)
        end
      end
      @position.increment()
      character = @position.current_character(@data)
    end
    return @tokens
  end
end