require 'database_patcher'
class DatabasePatcher::Command::CreatePatch < DatabasePatcher::Command
  names 'create_patch', 'add', 'new'
  desc 'create a new patch file with this tools convention'

  options = {}
  options[:type] = 'ruby'
  on '-t', '--type', 'this can be sql/ruby/rb. this will determine what will be the extension for the patch. Default is "ruby"' do |type|
    options[:type] = type
  end

  options[:idempotent] = false
  on '-i', '--idempotent', 'this will tell the patcher that the next patch does not require down part and so it is allowed to create as a simple file.' do
    options[:idempotent] = true
  end

  on_call do |args|
    std = DatabasePatcher::Interface::STD.new
    DatabasePatcher::Action::PatchCreator.new(options[:type], options[:idempotent],args.join('_'), std).make
  end
end
