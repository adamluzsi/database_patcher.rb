require 'optparse'
require 'database_patcher'
module DatabasePatcher::CLI
  extend(self)

  def start(argv)
    display_help(argv)
    command_name = argv[0]
    args = argv[1..-1]
    command = find_command_for(command_name)
    command.optparse.parse!(args)
    command.on_call.call(args)
  end

  protected

  def find_command_for(command_name)
    command = commands.find{|c| c.names.include?(command_name) }
    if command.nil?
      $stderr.puts("command not found: #{command_name}")
      exit
    end
    command
  end

  def display_help(argv)
    if argv.any?{|str| str =~ /\bh(?:elp)/ }
      options_parser.parse!(argv)
    end
    if argv[0] == 'help'
      if argv[1].nil?
        puts(options_parser.help)
      else
        puts(find_command_for(argv[1]).optparse.help)
      end
      exit
    end
  end

  def options_parser
    OptionParser.new do |opts|
      opts.banner.concat(' <COMMAND_NAME>')
      opts.banner.concat("\n\n")
      opts.banner.concat("The following commands supported: \n\n")

      commands.each do |subclass|
        opts.banner.concat("\tCommand: #{subclass.names.first}\n")
        opts.banner.concat("\taliases: #{subclass.names[1..-1].join(', ')}\n")
        opts.banner.concat("\tDescription: #{subclass.desc}\n")
        opts.banner.concat("\n\n")
      end
    end
  end

  def commands
    DatabasePatcher::Command.subclasses
  end
end
