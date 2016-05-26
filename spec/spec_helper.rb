$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'database_patcher'
require "dotenv"
Dotenv.load(File.join(File.dirname(__FILE__),'..','.env'))

RSpec.configuration.before do

  fixtures_path = File.join(File.dirname(__FILE__),'fixtures')
  allow(DatabasePatcher::Environment).to receive(:project_root_folder).and_return(fixtures_path)

end
