require 'database_patcher'
class DatabasePatcher::Command::RollBack < DatabasePatcher::Command
  names 'rollback', 'revert', 'step_back'
  desc 'execute the last patch down part, and remove the db patch registration'

  on_call do |*_|
    std = DatabasePatcher::Interface::STD.new
    DatabasePatcher::Action::Initializer.new(std).init
    DatabasePatcher::Action::PatchApplier.new(std).rollback
  end
end
