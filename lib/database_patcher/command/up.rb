require 'database_patcher'
class DatabasePatcher::Command::Up < DatabasePatcher::Command
  names 'apply_pending_patches', 'apply', 'up'
  desc 'apply all pending db patch'

  on_call do |*_|
    std = DatabasePatcher::Interface::STD.new
    DatabasePatcher::Action::Initializer.new(std).init
    DatabasePatcher::Action::PatchApplier.new(std).up
  end
end
