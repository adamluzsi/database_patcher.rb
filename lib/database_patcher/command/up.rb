require 'database_patcher'
class DatabasePatcher::Command::Up < DatabasePatcher::Command
  names 'apply_pending_patches', 'apply', 'up'
  desc 'apply all pending db patch'

  on_call do |*_|
    DatabasePatcher::Initializer.new.init
    DatabasePatcher::PatchApplier.new.up
  end
end
