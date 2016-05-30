require 'database_patcher'
class DatabasePatcher::Command::Down < DatabasePatcher::Command
  names 'revert_installed_patches', 'remove', 'down'
  desc 'execute the down patches and remove all db patch'

  on_call do |*_|
    std = DatabasePatcher::Interface::STD.new
    DatabasePatcher::Action::Initializer.new(std).init
    DatabasePatcher::Action::PatchApplier.new(std).down
  end
end
