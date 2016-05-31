require "database_patcher"
std = DatabasePatcher::Interface::STD.new
namespace :dp do

  desc 'apply pending schema migrations'
  task :up do
    DatabasePatcher::Action::Initializer.new(std).init
    DatabasePatcher::Action::PatchApplier.new(std).up
  end

  desc 'apply pending schema migrations'
  task :down do
    DatabasePatcher::Action::Initializer.new(std).init
    DatabasePatcher::Action::PatchApplier.new(std).down
  end

  desc 'rollback one patch'
  task :rollback do
    DatabasePatcher::Action::Initializer.new(std).init
    DatabasePatcher::Action::PatchApplier.new(std).rollback
  end

  desc 'create a new migration patch'
  task :add, :type, :idempotent, :description do |t, args|
    args.with_defaults(:type => 'ruby', :idempotent => false, :description => '')
    DatabasePatcher::Action::PatchCreator.new(args[:type], args[:idempotent],args[:description],std).make
  end

end
