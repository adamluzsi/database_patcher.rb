require 'database_patcher'
class DatabasePatcher::Action::PatchApplier < DatabasePatcher::Action
  def up
    connection = DatabasePatcher::DB.create_connection
    connection.transaction do
      fetcher = DatabasePatcher::Fetcher.new(connection, interface)
      fetcher.get_pending_patches.each do |pending_patch|
        pending_patch.up(connection)
      end
    end
  end

  def down
    return unless interface.ask('This will execute all the down patches! Are you sure?')
    connection = DatabasePatcher::DB.create_connection
    connection.transaction do
      fetcher = DatabasePatcher::Fetcher.new(connection, interface)
      fetcher.get_intalled_patches.each do |installed_patche|
        installed_patche.down(connection)
      end
    end
  end

  def rollback
    return unless interface.ask('This will execute the last patch down part! Are you sure?')
    connection = DatabasePatcher::DB.create_connection
    connection.transaction do
      fetcher = DatabasePatcher::Fetcher.new(connection, interface)
      fetcher.get_intalled_patches.each do |patch|
        patch.down(connection)
        break
      end
    end
  end

end
