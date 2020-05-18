# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!


# Set MySQL to clear sql mode for all connections
# http://stackoverflow.com/a/21615180/151007
class ActiveRecord::ConnectionAdapters::Mysql2Adapter 
  alias :connect_no_sql_mode :connect
  def connect
    connect_no_sql_mode
    execute("SET sql_mode = ''")
  end
end

ActiveRecord::Base.connection.reconnect!