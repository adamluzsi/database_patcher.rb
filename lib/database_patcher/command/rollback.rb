require 'database_patcher'
class DatabasePatcher::Command::RollBack < DatabasePatcher::Command
  names 'rollback', 'revert', 'step_back'
  desc 'execute the last patch down part, and remove the db patch registration'

  on_call do |*_|
    DatabasePatcher::Initializer.new.init
    DatabasePatcher::PatchApplier.new.rollback
  end
end
