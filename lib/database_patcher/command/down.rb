require 'database_patcher'
class DatabasePatcher::Command::Down < DatabasePatcher::Command
  names 'revert_installed_patches', 'remove', 'down'
  desc 'execute the down patches and remove all db patch'

  on_call do |*_|
    DatabasePatcher::Initializer.new.init
    DatabasePatcher::PatchApplier.new.down
  end
end
