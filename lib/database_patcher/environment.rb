require 'database_patcher'
module DatabasePatcher::Environment
  extend self

  def database_url
    ENV['DATABASE_URL'] || raise('missing database url from ENV (DATABASE_URL)')
  end

  def patch_folder_path
    folder_path = ENV['DATABASE_PATCH_FOLDER_PATH'] || File.join('db','patches')
    if folder_path[0] == File::Separator
      folder_path
    else
      File.join(project_root_folder, folder_path)
    end
  end

  def project_root_folder
    if bundler_loaded
      Bundler.root.to_s
    else
      Dir.pwd.to_s
    end
  end

  protected

  def bundler_loaded
    require('bundler')
    true
  rescue LoadError
    false
  end
end
