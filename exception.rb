require 'colorize'

class Exception
  def initialize(message, suggestion=nil, is_fatal=true)
    @message = message
    @is_fatal = is_fatal
    @suggestion = suggestion
  end

  def throw_exception
    print("Error:#{@message}".red)
    if @suggestion
      print(@suggestion.yellow)
    end
    if @is_fatal
      !exit
    end
  end
end 

def error(message, suggestion=nil, is_fatal=true)
  exception = Exception.new(message, suggestion, is_fatal)
  exception.throw_exception()
end