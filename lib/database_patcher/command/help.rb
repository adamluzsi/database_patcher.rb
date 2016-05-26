require 'database_patcher'
class DatabasePatcher::Command::Help < DatabasePatcher::Command
  names 'help'
  optparse.banner.concat(' <COMMAND_NAME>')
  desc 'show command specific help message'

  on_call do |args|
    commands = DatabasePatcher::Command.subclasses

    options_parser = OptionParser.new do |opts|
      opts.banner.concat(' <COMMAND_NAME>')
      opts.banner.concat("\n\n")
      opts.banner.concat("The following commands supported: \n\n")

      commands.each do |subclass|
        opts.banner.concat("\tCommand: #{subclass.names.first}\n")
        opts.banner.concat("\taliases: #{subclass.names[1..-1].join(', ')}\n")
        opts.banner.concat("\tDescription: #{subclass.desc}\n")
        opts.banner.concat("\n")
      end
    end

    command_name = args[0]
    parser = if command_name.nil?
               options_parser
             else
               command = commands.find { |c| c.names.include?(command_name) }
               if command.nil?
                 $stderr.puts("command not found: #{command_name}")
                 exit
               end
               command.optparse
    end

    puts(parser.help)
    exit
  end
end
