require_relative 'utilities'

module Ferry
  class Dumper < Utilities
    possible_content = %w[dump functions triggers views indexes constraints schemas]
    def dump(content)
      if check_if_valid_request(content)
        case db_connect(environment)
        when 'sqlite3'
          get_content_from_sqlite(content)
        when 'postgresql'
          get_content_from_postgresql(content)
        when 'mysql2'
          get_content_from_mysql(content)
        else
          raise "#{db_type} is not supported by ferry at this time"
          return false
        end
      else
        raise "Incorrect content specified to dump from database"
      end
    end

    def check_if_valid_request(content)
      possible_content.include(content) ? true : false
    end

    def get_sqlite(content)

    end

    def get_postgresql(content)
    end

    def get_mysql(content)
    end
  end
end
