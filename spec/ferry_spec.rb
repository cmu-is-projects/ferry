require 'spec_helper'

describe "connect" do
  context "connect" do
    it "id" do
      Post.by_year.map(&:text).should include("First post!")
    end
  end

end