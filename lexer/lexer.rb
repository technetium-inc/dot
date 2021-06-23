require_relative "./position.rb"
require_relative "../exception.rb"

NUMBERS = Array(0..9).map do |number|
  String(number)
end

class NumberToken 
  def initialize(data, position, filename, line_number)
    @data = data
    @position = position
    @filename = filename
    @line_number = line_number
  end

  def is_valid_number(number_string)
    if number_string.end_with?("_")
      number_string += "0"
    end
    if number_string.start_with?("_")
      number_string = "0" + number_string
    end
    return number_string.gsub("_", "")
  end

  def create_number()
    character = @position.current_character(@data)
    number_string, dot_count = "", 0
    while character != nil && (Array(NUMBERS + ["_", "."]).include?(character)) do
      if character == "."
        if dot_count >= 1
          runtime_error("Number cannot contain more than 1 decimal point", @filename, @line_number)
        end
        dot_count += 1
      end
      number_string += character
      @position.increment()
      character = @position.current_character(@data)
    end

    return {"value" => is_valid_number(number_string), "type" => dot_count > 0 ? "float" : "int"}
  end

end

class LexerToken
  def initialize(name, token_type)
    @name = name
    @token_type = token_type
  end
end

class LexicalAnalyser

  def initialize(data, filename)
    @data = data
    @filename = filename
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
        @line_number += 1
        @tokens.push(LexerToken.new(character, "NEWLINE"))
      else
        if NUMBERS.include?(character)
          number = NumberToken.new(@data, @position, @filename, @line_number).create_number()
          type = number["type"]
          token = LexerToken.new(number["value"], "NUMBER:#{type}")
          @tokens.push(token)
        end
      end
      @position.increment()
      character = @position.current_character(@data)
    end
    return @tokens
  end
end