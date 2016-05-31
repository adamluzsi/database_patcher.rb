require 'timeout'
require 'database_patcher'
class DatabasePatcher::Interface::STD < DatabasePatcher::Interface
  def initialize(options = {})
    @force = !!options[:force]
  end

  def ask(question)
    return true if @force
    Timeout.timeout(15) do
      loop do
        $stdout.puts(question.to_s + ' ([y]es/[n]o)')
        case $stdin.gets.chomp.strip.downcase 
        when 'y', 'yes'
          return true
        when 'n', 'no'
          return false
        else
          $stdout.puts('invalid answer, please try again')
        end
      end
    end
  end
end
