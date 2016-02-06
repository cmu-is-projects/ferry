require 'rake/file_creation_task'

module Ferry
  class UploadTask < Rake::FileCreationTask
    def needed?
      true # always needed because we can't check remote hosts duhhhhhh
    end
  end
end
