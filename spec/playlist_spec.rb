require 'spec_helper'

describe Hypem::Playlist do
  let(:user) { Hypem::User.new('jackca') }
  let(:playlist) { VCR.use_cassette('loved_playlist') {user.loved_playlist} }

  context "when initialized" do
    let(:tracks) { playlist.tracks }

    it "assigns tracks attribute" do
      tracks.first.should be_a Hypem::Track
    end

    it "throws an error with invalid parameters" do
      expect { Hypem::Playlist.new(:symbol) }.to raise_error(ArgumentError)
    end
  end

  describe "self.get" do

    it "requires two parameters" do
      expect { Hypem::Playlist.get(:one_parameter) }.to raise_error(ArgumentError)
    end

  end

end
