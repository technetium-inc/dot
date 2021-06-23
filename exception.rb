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

class RuntimeException < Exception 
  def initialize(message, filename, line_number, suggestion, is_fatal=true)
    @message = "#{message}\nIn #{filename} at line #{line_number}"
    @suggestion = suggestion
    @is_fatal = is_fatal
  end

  def throw_exception()
    super
  end
end

def runtime_error(msg, file, line, suggestion=nil, is_fatal=true)
  exception = RuntimeException.new(msg, file, line, suggestion, is_fatal)
  exception.throw_exception()
end

def error(message, suggestion=nil, is_fatal=true)
  exception = Exception.new(message, suggestion, is_fatal)
  exception.throw_exception()
end