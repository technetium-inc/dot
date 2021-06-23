require_relative "./arguments.rb"
require_relative "./exception.rb"
require_relative "./lexer/lexer.rb"

COMMANDS = {
  "help" => ->(parameters) {
    print("Helping")
  }
}

def execute_script(filename, parameters)
  if not File.file?(filename)
    error("#{filename} does not exist")
  end
  lexer = LexicalAnalyser.new(File.read(filename)).tokenise()
end

def perform_command(results)
  command, params = results.command, results.parameters
  if COMMANDS.has_key?(command)
    execute_function = COMMANDS[command]
    execute_function.call(params)
  else
    execute_script(command, params)
  end
end

def main()
  argument_parser = ArgumentParser.new(ARGV)
  arguments = argument_parser.parse_arguments()
  perform_command(arguments)
end

result = main()