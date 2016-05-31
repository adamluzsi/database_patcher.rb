require 'database_patcher'
class DatabasePatcher::Action::Initializer < DatabasePatcher::Action
  def init
    create_patch_folder
    check_table_exists
    check_required_columns
  rescue Sequel::DatabaseError => explanation
    connection.create_table(:installed_patches) do
      Integer :timestamp
      String :uuid, size: 36
      String :md5_down, size: 32
      String :md5_up, size: 32
      String :comment
    end
  end

  protected

  def check_required_columns
    test_column(:timestamp, Integer)
    test_column(:uuid, String, size: 36, default: "")
    test_column(:md5_down, String, size: 32)
    test_column(:md5_up, String, size: 32)
    test_column(:md5_up, String, size: 32)
    test_column(:comment, String)
  end

  def test_column(name, type, opts = {})
    connection.transaction do
      unless connection[:installed_patches].columns.include?(name)
        connection.alter_table(:installed_patches) do
          add_column(name, type, opts)
        end
      end
    end
  end

  def check_table_exists
    connection[:installed_patches].first
  end

  def create_patch_folder
    FileUtils.mkpath(DatabasePatcher::Environment.patch_folder_path)
  end

  def connection
    @connection ||= DatabasePatcher::DB.create_connection
  end
end
