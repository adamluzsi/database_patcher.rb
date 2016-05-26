require 'database_patcher'
class DatabasePatcher::Command::Init < DatabasePatcher::Command
  names 'initialize', 'init', 'setup'
  desc 'this will create initial directory and the default installed_patches table in the database'

  on_call do |*_|
    DatabasePatcher::Initializer.new.init
  end
end
