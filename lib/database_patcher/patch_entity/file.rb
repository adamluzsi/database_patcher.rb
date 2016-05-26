require 'database_patcher'
class DatabasePatcher::PatchEntity::File < DatabasePatcher::PatchEntity
  def up(connection)
    execute_file(connection, @path)
    register_this_patch(connection)
  end

  def down(connection)
    unregister_this_patch(connection)
  end

  def md5_down
    ''
  end

  def md5_up
    md5(::File.read(@path))
  end

  def comment
    get_comment(@path)
  end
end
