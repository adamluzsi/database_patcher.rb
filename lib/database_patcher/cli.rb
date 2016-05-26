require 'optparse'
require 'database_patcher'
module DatabasePatcher::CLI
  extend(self)

  def start(argv)
    options = {}
    options_parser(options).parse!(argv)

    patch_applier.public_send()
  end

  protected

  def options_parser(options)
    OptionParser.new do |opts|
      opts.banner.concat(' <COMMAND_NAME>')
      opts.banner.concat("\n\n")
      opts.banner.concat("The following commands supported: \n")
      opts.banner.concat((DatabasePatcher.methods - Object.methods).join(', '))
    end
  end

  def patch_applier
    @patch_applier ||= DatabasePatcher::PatchApplier.new
  end
end
