require "database_patcher"
namespace :db do

  desc 'apply pending schema migrations'
  task :apply_pending_patches do
    DatabasePatcher::Initializer.new.init
    DatabasePatcher::PatchApplier.new.up
  end

  desc "Alias task for apply_pending_patches"
  task :migrate => :apply_pending_patches

  desc 'apply pending schema migrations'
  task :revert_installed_patches do
    DatabasePatcher::Initializer.new.init
    DatabasePatcher::PatchApplier.new.down
  end

  desc 'rollback one patch'
  task :rollback do
    DatabasePatcher::Initializer.new.init
    DatabasePatcher::PatchApplier.new.rollback
  end

  desc 'create a new migration patch'
  task :create_patch, :type, :idempotent, :description do |t, args|
    args.with_defaults(:type => 'ruby', :idempotent => false, :description => '')
    DatabasePatcher::PatchCreator.new(args[:type], args[:idempotent],args[:description]).make
  end

end
