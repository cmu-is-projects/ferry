class Logger
  def initialize(options={})
    @homedir = options[:homedir] ||= "log"
    FileUtils.mkdir @homedir unless Dir[@homedir].present?
    FileUtils.touch "#{@homedir}/ferry.log"
  end

  def write(msg)
    log = File.open("#{@homedir}/ferry.log", 'w')
    log.puts msg
  end
end
