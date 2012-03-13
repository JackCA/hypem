require 'spec_helper'

describe Hypem::Playlist do
  let(:user) { Hypem::User.new('jackca') }
  let(:playlist) { VCR.use_cassette('loved_playlist') {user.loved_playlist} }

  context "when initialized" do
    let(:tracks) { playlist.instance_variable_get(:@tracks) } 

    it "is initialized with a hash" do
      tracks.should be_an Array 
    end

    it "initializes its tracks" do
      tracks.first.should be_a Hypem::Track
    end
  end

  it "throws an error with invalid parameters" do
    expect { Hypem::Playlist.new(:symbol) }.to raise_error(ArgumentError)
  end

  it "gets a generic playlist" do
    VCR.use_cassette('popular_playlist') { Hypem::Playlist.get('popular/3day') }.should be_a Hypem::Playlist
  end

end
