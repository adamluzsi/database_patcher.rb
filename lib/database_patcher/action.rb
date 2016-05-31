require 'database_patcher'
class DatabasePatcher::Action
  require 'database_patcher/action/initializer'
  require 'database_patcher/action/patch_applier'
  require 'database_patcher/action/patch_creator'

  attr_reader :interface
  def initialize(interface=DatabasePatcher::Interface::Null.new)
    @interface = interface
  end
end
