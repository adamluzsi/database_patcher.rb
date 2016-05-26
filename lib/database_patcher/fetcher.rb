require 'database_patcher'
class DatabasePatcher::Fetcher
  def initialize(connection)
    @connection = connection
  end

  def get_intalled_patches
    patches = get_patches.reverse
    installed_patches = []
    already_applied_patch_timestamps = get_already_applied_patch_timestamps

    patches.each do |patch|
      break unless already_applied_patch_timestamps.include?(patch.timestamp)
      installed_patches.push(patch)
    end

    installed_patches
  end

  def get_pending_patches
    patches = get_patches
    pending_patches = []
    already_applied_patch_timestamps = get_already_applied_patch_timestamps

    patches.each do |patch|
      break if already_applied_patch_timestamps.include?(patch.timestamp)
      pending_patches.push(patch)
    end

    pending_patches
  end

  protected

  attr_reader :connection

  def get_patches
    Dir.glob(File.join(DatabasePatcher::Environment.patch_folder_paths, '*')).reduce([]) do |patches, current_path|
      patches << DatabasePatcher::PatchEntity.factory(current_path)
      patches
    end.sort_by(&:timestamp)
  end

  def installed_patches
    connection[:installed_patches].all
  end

  def get_already_applied_patch_timestamps
    installed_patches.map { |record| record[:timestamp] }
  end
end
