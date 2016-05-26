require "optparse"
require 'database_patcher'
class DatabasePatcher::Command
  class << self
    def inherited(subclass)
      subclasses << subclass
    end

    def subclasses
      @subclasses ||= []
    end

    def on_call(&block)
      @on_call ||= block unless block.nil?
      @on_call || -> {}
    end

    def names(*new_names)
      unless new_names.empty?
        @names = new_names
        optparse.banner = OptionParser.new.banner + " <#{new_names.join('|')}>"
      end
      @names
    end

    def desc(message = nil)
      @desc = message unless message.nil?
      @desc
    end

    def options(hash = nil)
      @options ||= {}
      @options.merge!(hash) if hash.is_a?(Hash)
      @options
    end

    def on(*args,&block)
      optparse.on(*args,&block)
    end

    def optparse
      @optparse ||= OptionParser.new
    end

  end

  require 'database_patcher/Command/create_patch'
  require 'database_patcher/Command/init'
  require 'database_patcher/Command/up'
  require 'database_patcher/Command/down'
  require 'database_patcher/Command/rollback'
end
