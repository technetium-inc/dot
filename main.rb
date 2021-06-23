require_relative "./arguments.rb"

def main()
  argument_parser = ArgumentParser.new(ARGV)
  arguments = argument_parser.parse_arguments()
end

result = main()