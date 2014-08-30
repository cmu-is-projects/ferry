class Engine
  def initialize(options={})
  end

  def run(options, &block)
    log = options[:log]
    collection = options[:batch]
    log.write "collection length: #{collection.length}"
    begin
      instance_exec(collection, &block)
    rescue Exception => e
      log.write "Error: #{e}"
    end
    log.write "worker finished"
  end
end
