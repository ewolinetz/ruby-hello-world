require 'sinatra/activerecord'
require 'pg'

def self.connect_to_database_prod
  begin
    config = {
      :adapter  => "postgresql",
      :host     => "#{ENV["DATABASE_SERVICE_HOST"]}",
      :port     => "#{ENV["DATABASE_SERVICE_PORT"]}",
      :database => "#{ENV["POSTGRESQL_DATABASE"]}"
    }
    if ENV.key?("POSTGRESQL_ROOT_PASSWORD")
      config[:password] = "#{ENV["POSTGRESQL_ROOT_PASSWORD"]}"
    else
      config[:username] = "#{ENV["POSTGRESQL_USER"]}"
      config[:password] = "#{ENV["POSTGRESQL_PASSWORD"]}"
    end

    puts "Connecting to production database (#{config[:username]}@#{config[:host]}:#{config[:port]})..."
    ActiveRecord::Base.establish_connection(config)

    ActiveRecord::Base.connection.active?

  rescue Exception => e
    if not /Can't connect to POSTGRESQL server/ =~ e.message
      puts e.message
    end
    return false
  end
end

def self.check_for_tables_prod
  begin
    config = {
      :adapter  => "postgresql",
      :host     => "#{ENV["DATABASE_SERVICE_HOST"]}",
      :port     => "#{ENV["DATABASE_SERVICE_PORT"]}",
      :database => "#{ENV["POSTGRESQL_DATABASE"]}"
    }
    if ENV.key?("POSTGRESQL_ROOT_PASSWORD")
      config[:password] = "#{ENV["POSTGRESQL_ROOT_PASSWORD"]}"
    else
      config[:username] = "#{ENV["POSTGRESQL_USER"]}"
      config[:password] = "#{ENV["POSTGRESQL_PASSWORD"]}"
    end

    puts "Connecting to production database (#{config[:username]}@#{config[:host]}:#{config[:port]})..."
    ActiveRecord::Base.establish_connection(config)

    ActiveRecord::Base.connection.active?

    puts "Checking for existance of table (key_pairs)..."
    ActiveRecord::Base.connection.table_exists? 'key_pairs'

  rescue Exception => e
    if not /Can't connect to POSTGRESQL server/ =~ e.message
      puts e.message
    end
    return false
  end
end

def self.close_connections
  begin

  ActiveRecord::Base.finish

  rescue Exception => e
    if not /Can't close connection to POSTGRESQL server/ =~ e.message
      puts e.message
    end
    return false
  end
end

def self.connect_to_database_test
  begin
    config = {
      :adapter  => "postgresql",
      :host     => "#{ENV["DATABASE_TEST_SERVICE_HOST"]}",
      :port     => "#{ENV["DATABASE_TEST_SERVICE_PORT"]}",
      :database => "#{ENV["POSTGRESQL_DATABASE"]}"
    }
    if ENV.key?("POSTGRESQL_ROOT_PASSWORD")
      config[:password] = ENV["POSTGRESQL_ROOT_PASSWORD"]
    else
      config[:username] = ENV["POSTGRESQL_USER"]
      config[:password] = ENV["POSTGRESQL_PASSWORD"]
    end

    puts "Connecting to test database (#{config[:username]}@#{config[:host]}:#{config[:port]})..."
    ActiveRecord::Base.establish_connection(config)

    ActiveRecord::Base.connection.active?

  rescue Exception => e
    if not /Can't connect to POSTGRESQL server/ =~ e.message
      puts e.message
    end
    return false
  end
end
