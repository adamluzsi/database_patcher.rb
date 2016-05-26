require 'fileutils'
module DatabasePatcher
  require 'database_patcher/db'
  require 'database_patcher/version'
  require 'database_patcher/environment'

  require 'database_patcher/fetcher'
  require 'database_patcher/initializer'
  require 'database_patcher/patch_entity'
  require 'database_patcher/patch_applier'

  extend self

  def init
    DatabasePatcher::Initializer.new.init
  end

  def up
    init
    DatabasePatcher::PatchApplier.new.up
  end

  def down
    init
    DatabasePatcher::PatchApplier.new.down
  end

  def rollback
    init
    DatabasePatcher::PatchApplier.new.rollback 
  end
end
