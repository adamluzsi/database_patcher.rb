require 'digest'
require 'logger'
require 'sequel'
require 'database_patcher'
module DatabasePatcher::DB
  extend self

  def create_connection
    new_connection = Sequel.connect(DatabasePatcher::Environment.database_url)
    new_connection.sql_log_level = :info
    new_connection.loggers << new_logger
    new_connection
  end

  def new_logger
    logger = Logger.new($stdout)
    logger.level = Logger::Severity::ERROR
    logger
  end

  def valid_connection?(connection)
    !connection.nil? && connection.test_connection
  rescue
    false
  end
end
