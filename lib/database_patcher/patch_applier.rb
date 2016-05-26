require 'database_patcher'
class DatabasePatcher::PatchApplier
  def up
    connection = DatabasePatcher::DB.create_connection
    connection.transaction do
      fetcher = DatabasePatcher::Fetcher.new(connection)
      fetcher.get_pending_patches.each do |pending_patch|
        pending_patch.up(connection)
      end
    end
  end

  def down
    connection = DatabasePatcher::DB.create_connection
    connection.transaction do
      fetcher = DatabasePatcher::Fetcher.new(connection)
      fetcher.get_intalled_patches.each do |installed_patche|
        installed_patche.down(connection)
      end
    end
  end

  def rollback
    connection = DatabasePatcher::DB.create_connection
    connection.transaction do
      fetcher = DatabasePatcher::Fetcher.new(connection)
      fetcher.get_intalled_patches.each do |patch|
        patch.down(connection)
        break
      end
    end
  end

end
