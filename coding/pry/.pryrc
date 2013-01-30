# Pry
# -new alternative of irb-
#

Pry.config.editor = "vim"
Pry.config.theme = "monokai"
Pry.config.history.file = "~/var/log/.pry_history"

Pry.config.prompt_name = File.basename(Dir.pwd)
Pry.config.prompt = [proc {|obj,nest_level,pry| "[#{pry.input_array.size}] pry:#{obj}> "},
                     proc {"     | "}]

# awesome_print
require 'rubygems' if RUBY_VERSION < '1.9'
require 'awesome_print'

Pry.print = proc{|output,value| output.puts value.ai}

begin
  require 'pry-clipboard'
  # Pry.config.commands.alias_command 'ch', 'copy-history'
  # Pry.config.commands.alias_command 'cr', 'copy_result'
rescue LoadError => e
  warn "can't load pry-clipboard"
end

Pry.commands.alias_command 'c', 'continue'
Pry.commands.alias_command 's', 'step'
Pry.commands.alias_command 'n', 'next'
Pry.commands.alias_command 'f', 'finish'

