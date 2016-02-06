namespace :deploy do

  desc "Preparing ferry for deployment."
  task :starting do
  end

  desc 'Started'
  task :started do
  end

  desc 'Revert database to previous release.'
  task :reverting do
  end

  desc 'Reverted'
  task :reverted do
  end

  desc 'Finish the deployment, cleaning up.'
  task :finishing do
  end

  desc 'Finish the rollback, clean up.'
  task :finishing_rollback do
  end

  desc 'Finished'
  task :finished do
  end

  desc 'Rollback to previous release.'
  task :rollback do
    %w{ starting started
        reverting reverted
        publishing published
        finishing_rollback finished }.each do |task|
      invoke "deploy:#{task}"
    end
  end
end

desc 'Deploy a new release.'
task :deploy do
  set(:deploying, true)
  %w{ starting started
      updating updated
      publishing published
      finishing finished }.each do |task|
    invoke "deploy:#{task}"
  end
end
task default: :deploy
