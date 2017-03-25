# The start of this comes from "Building Awesome Command Line Apps with Ruby"

require "json"
require "readline"
require "optparse"

class Context
  attr_reader :here, :parent_context
  def initialize(here, parent_context)
    @here = here
    @parent_context = parent_context
  end

  def to_s
    if self.here.kind_of?(Array)
      indices = []
      self.here.each_index {|i| indices << i }
      indices.join(' ')
    elsif self.here.kind_of?(Hash)
      self.here.keys.join(' ')
    else
      self_here.to_s
    end
  end
  
  def cat(path)
    item_at(path)
  end

  def cd(path)
    if path == '..'
      self.parent_context
    else
      item = item_at(path)
      if item.nil?
        nil
      else
        Context.new(item, self)
      end
    end
  end

  private

  def item_at(path)
    if path == '..'
      self.parent_context.here
    elsif self.here.kind_of?(Array)
      self.here[path.to_i]
    elsif self.here.kind_of?(Hash)
      self.here[path]
    else
      nil
    end 
  end
end

option_parser = OptionParser.new do |opts|
  executable_name = File.basename($PROGRAM_NAME)
  opts.banner = "Interactive JSON browser and editor.
  Usage: #{executable_name} json_file"
end

option_parser.parse!

 
def execute_command(command, current_context)
  case command
  when /^ls$/
    puts current_context.to_s
  when /^cd (.*$)/
    new_context = current_context.cd($1)
    if new_context.nil?
      puts "No such key: #{$1}"
    else
      current_context = new_context
    end
  when /^cat (.*)$/
    item = current_context.cat($1)
    if item.nil?
      puts "No such item #{$1}"
    else
      puts item.inspect
    end
  when /^help$/
    puts "cat, cd, ls"
  end
  current_context
end

def main(json_file)
  root = JSON.parse(File.read(json_file))
  command = nil

  current_context = Context.new(root, nil)

  while command != "exit"
    command = Readline.readline("> ", true)
    break if command.nil?
    current_context = execute_command(command.strip, current_context)
  end  
end

json_file = ARGV.shift
if json_file && File.exists?(json_file)
  main(json_file)
else
  STDERR.puts "error: you must provide a json file as an argument."
  exit 1
end

