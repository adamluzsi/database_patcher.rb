require 'database_patcher'
class DatabasePatcher::Initializer
  def init
    create_patch_folder
    check_table_exists
  rescue Sequel::DatabaseError
    connection.create_table(:installed_patches) do
      Integer :timestamp
      String :md5_down, size: 32
      String :md5_up, size: 32
      String :comment
    end
  end

  protected

  def check_table_exists
    connection[:installed_patches].first
  end

  def create_patch_folder
    FileUtils.mkpath(DatabasePatcher::Environment.patch_folder_paths)
  end

  def connection
    @connection ||= DatabasePatcher::DB.create_connection
  end
end
