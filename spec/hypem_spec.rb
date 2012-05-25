require 'spec_helper'

describe Hypem do
  describe "convenience methods" do
    it "can access playlist class" do
      Hypem.playlist.should == Hypem::Playlist
    end

    it "can access user class" do
      Hypem.user('jackca').should be_a Hypem::User
    end
  end
end
