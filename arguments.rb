require_relative "./exception.rb"

class ArgumentParserResults
  attr_reader :command, :parameters

  def initialize(command, parameters)
    @command = command
    @parameters = parameters
  end
end

class ArgumentParser
  attr_accessor :arguments

  def initialize(arguments)
    @arguments = arguments
  end

  def parse_arguments()
    current_index = 0
    command, parameters = "help", []
    while current_index < @arguments.length 
      argument = @arguments[current_index]
      if current_index == 0
        command = argument
        current_index += 1
        next
      end
      is_valid_parameters = argument.start_with?("--")
      if not is_valid_parameters
        error("#{argument} not a valid parameter\n", "Parameters should start with --")
        return nil
      end
      parameters.push(argument)
      current_index += 1
    end
    return ArgumentParserResults.new(command, parameters)
  end
end