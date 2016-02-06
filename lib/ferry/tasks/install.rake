require 'erb'
require 'pathname'
desc 'Install Ferry, ferry install STAGES=test,development,production'
task :install do
  envs = ENV['STAGES'] || 'test,development,production'

  tasks_dir = Pathname.new('lib/ferry/tasks')
  config_dir = Pathname.new('config')
  deploy_dir = config_dir.join('deploy_ferry')

  deploy_rb = File.expand_path("../../templates/deploy_ferry.rb.erb", __FILE__)
  stage_rb = File.expand_path("../../templates/stage.rb.erb", __FILE__)
  ferryfile = File.expand_path("../../templates/Ferryfile", __FILE__)

  mkdir_p deploy_dir

  entries = [{template: deploy_rb, file: config_dir.join('deploy.rb')}]
  entries += envs.split(',').map { |stage| {template: stage_rb, file: deploy_dir.join("#{stage}.rb")} }

  entries.each do |entry|
    if File.exists?(entry[:file])
      warn "[skip] #{entry[:file]} already exists"
    else
      File.open(entry[:file], 'w+') do |f|
        f.write(ERB.new(File.read(entry[:template])).result(binding))
        puts I18n.t(:written_file, scope: :ferry, file: entry[:file])
      end
    end
  end

  mkdir_p tasks_dir

  if File.exists?('Ferryfile')
    warn "[skip] Ferryfile already exists"
  else
    FileUtils.cp(ferryfile, 'Ferryfile')
    puts I18n.t(:written_file, scope: :ferry, file: 'Ferryfile')
  end

  puts I18n.t :set_sail, scope: :deploy
end
