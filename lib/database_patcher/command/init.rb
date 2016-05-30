require 'database_patcher'
class DatabasePatcher::Command::Init < DatabasePatcher::Command
  names 'initialize', 'init', 'setup'
  desc 'this will create initial directory and the default installed_patches table in the database'

  on_call do |*_|
    std = DatabasePatcher::Interface::STD.new
    DatabasePatcher::Action::Initializer.new(std).init
  end
end
