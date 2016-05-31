require 'database_patcher'
class DatabasePatcher::Fetcher
  def initialize(connection, interface)
    @connection = connection
    @interface = interface
  end

  def get_intalled_patches
    patches = get_patches
    installed_patches = []
    uniq_indentifiers = get_already_applied_patch_uniq_indentifiers

    patches.each do |patch|
      break unless uniq_indentifiers.include?(patch.uniq_indentifier)
      installed_patches.push(patch)
    end

    installed_patches.reverse
  end

  def get_pending_patches
    patches = get_patches
    pending_patches = []
    uniq_indentifiers = get_already_applied_patch_uniq_indentifiers

    patches.each do |patch|
      break if uniq_indentifiers.include?(patch.uniq_indentifier)
      pending_patches.push(patch)
    end

    pending_patches
  end

  protected

  attr_reader :connection

  def get_patches
    Dir.glob(File.join(DatabasePatcher::Environment.patch_folder_path, '*')).reduce([]) do |patches, current_path|
      patches << DatabasePatcher::PatchEntity.factory(current_path, @interface)
      patches
    end.sort_by(&:timestamp)
  end

  def installed_patches
    connection[:installed_patches].all
  end

  def get_already_applied_patch_uniq_indentifiers
    installed_patches.map do |record|
      {
        timestamp: record[:timestamp],
        uuid: record[:uuid]
      }
    end.sort_by{|r| r[:timestamp].to_i }
  end
end
