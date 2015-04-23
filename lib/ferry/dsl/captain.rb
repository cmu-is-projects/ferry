require 'ferry'

class Captain < Ferry
  # after initializing some captain class
  # we need to be able to
  # 0 know what kind of content we want to move
  # 1 know where we need to move data from
  # 2 know where we need to move data to
  # 3 any specifics of
  def initialize(**opts)
    # @cargo ||= opts[:cargo]
    # @start ||= opts[:to_loc]
    # @ends ||= opts[:form_loc]
  end
end
