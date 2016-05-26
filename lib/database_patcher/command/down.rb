require 'database_patcher'
class DatabasePatcher::Command::Down < DatabasePatcher::Command
  names 'execute_all_remove_patch', 'apply', 'up'
  desc 'execute the down patches and remove all db patch'

  on_call do |*_|
    DatabasePatcher::Initializer.new.init
    DatabasePatcher::PatchApplier.new.down
  end
end
