require 'fileutils'
require 'database_patcher'
class DatabasePatcher::PatchCreator
  def initialize(type, idenpotent, file_name_description)
    @type = type
    @idenpotent = !!idenpotent
    @file_name_description = file_name_description
  end

  def make
    if @idenpotentg
      file_path = base_path + extension
      FileUtils.touch(file_path)
      puts(file_path)
    else
      FileUtils.mkpath(base_path)
      FileUtils.touch(File.join(base_path,'up' + extension))
      FileUtils.touch(File.join(base_path,'down' + extension))
      puts(base_path)
    end
  end

  protected

  def base_path
    File.join(DatabasePatcher::Environment.patch_folder_path, basename)
  end

  def basename
    [Time.now.to_i.to_s,@file_name_description].compact.join('_').gsub(/ +/,'_')
  end

  def extension
    case @type
    when 'ruby','rb'
      '.rb'
    when 'sql'
      '.sql'
    else
      raise("unknown format: #{@type}")
    end
  end
end
