require 'digest/md5'
require 'database_patcher'
class DatabasePatcher::PatchEntity
  require 'database_patcher/patch_entity/file'
  require 'database_patcher/patch_entity/folder'

  def self.factory(path)
    if ::File.directory?(path)
      self::Folder.new(path)
    else
      self::File.new(path)
    end
  end

  def initialize(path)
    @path = path
  end

  def timestamp
    basename = ::File.basename(@path, '.*')
    basename.scan(/^\d+/).flatten.first.to_i
  end

  def up(_connection)
    raise
  end

  def down(_connection)
    raise
  end

  def execute_file(connection, path)
    case ::File.extname(path)

    when '.rb', '.ru'
      connection.instance_eval(::File.read(path))

    when '.sql'
      connection.run(::File.read(path))

    else
      raise_unknown_extension_for(path)

    end
  end

  def register_this_patch(connection)
    connection[:installed_patches].insert(patch_record)
  end

  def unregister_this_patch(connection)
    connection[:installed_patches].where(uniq_indentifier).delete
  end

  def uniq_indentifier
    {
      timestamp: timestamp,
      md5_down: md5_down,
      md5_up: md5_up
    }
  end

  def patch_record
    uniq_indentifier.merge(comment: comment)
  end

  def md5(string)
    ::Digest::MD5.hexdigest(string)
  end

  def get_comment(file_path)
    case ::File.extname(file_path)

    when '.rb', '.ru'
      extract_comments(file_path, '#')

    when '.sql'
      extract_comments(file_path, '--')

    else
      raise_unknown_extension_for(file_path)
    end
  end

  def extract_comments(file_path, comment_seperator)
    ::File.read(file_path).scan(/#{comment_seperator}(.*)/).flatten.map(&:strip).join("\n")
  end

  def accepted_extensions
    %w(rb ru sql)
  end

  def raise_unknown_extension_for(path)
    raise("unknown patch file extension: #{::File.extname(path)} (#{path})")
  end
end
