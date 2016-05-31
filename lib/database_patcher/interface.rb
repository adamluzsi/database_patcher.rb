require 'database_patcher'
class DatabasePatcher::Interface
  require 'database_patcher/interface/null'
  require 'database_patcher/interface/std'

  def ask(_question)
    raise(NotImplementedError)
  end
end
