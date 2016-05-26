require 'database_patcher'
class DatabasePatcher::PatchEntity::Folder < DatabasePatcher::PatchEntity
  def up(connection)
    execute_from_folder('up', connection)
    register_this_patch(connection)
  end

  def down(connection)
    execute_from_folder('down', connection)
    unregister_this_patch(connection)
  end

  def md5_up
    md5(::File.read(file_path_for('up')))
  end

  def md5_down
    md5(::File.read(file_path_for('down')))
  end

  def comment
    comments = []

    up_comment = get_comment(file_path_for('up'))
    down_comment = get_comment(file_path_for('down'))

    if up_comment != ''
      comments << 'UP:'
      comments << up_comment
    end

    if down_comment != ''
      comments << "" if up_comment != ''
      comments << 'DOWN:'
      comments << down_comment
    end

    comments.join("\n")
  end

  protected

  def execute_from_folder(patch_type, connection)
    execute_file(connection, file_path_for(patch_type))
  end

  def file_path_for(patch_type)
    file_selector = ::File.join(@path, "#{patch_type}.{#{accepted_extensions.join(',')}}")
    file_path = Dir.glob(file_selector).first
  end
end
