require 'database_patcher'
class DatabasePatcher::Interface::Null < DatabasePatcher::Interface
  def ask(_q)
    true
  end
end
