require "ferry/version"
require "ferry/engine"
require "ferry/logger"

module Ferry
  class Hello
    def say_hello
      puts 'Hello Wurld.'
    end
  end

  class ActiveRecord::Relation
    def migrate(options, &block)
      options[:max_workers] ||= 4
      options[:batch_size]  ||= 10_000

      log = Logger.new()

      active_workers = []
      collection = self
      collection.find_in_batches(batch_size: options[:batch_size]) do |batch|
        if active_workers.length >= options[:max_workers]
          log.write "active_workers oversized at capacity of #{active_workers.length}/#{options[:max_workers]}"
          finished_process = Process.wait
          log.write "finished_process: #{finished_process}"
          active_workers.delete finished_process
          log.write "active_workers capacity now at: #{active_workers.length}/#{options[:max_workers]}"
        else
          active_workers << fork do
            ActiveRecord::Base.connection.reconnect!
            log.write "kicking off engine on batch(#{batch.first}-#{batch.last})"
            engine = Engine.new()
            engine.run({log: log, batch: batch}, &block)
          end
        end
        ActiveRecord::Base.connection.reconnect!
      end
    end
  end
end
