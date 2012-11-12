# Pry
# -new alternative of irb-
#

Pry.config.editor = "vim"
Pry.config.theme = "monokai"

Pry.config.prompt_name = File.basename(Dir.pwd)
Pry.config.prompt = [proc {|obj,nest_level,pry| "[#{pry.input_array.size}] pry:#{obj}> "},
                     proc {"     | "}]

# awesome_print
require 'rubygems' if RUBY_VERSION < '1.9'
require 'awesome_print'

Pry.print = proc{|output,value| output.puts value.ai}
