
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
      is_valid_parameters = argument.starts_with("--")
      if not is_valid_parameters
        print("Not valid")
        return nil
      end
      parameters.push(argument)
      current_index += 1
    end
  end
end