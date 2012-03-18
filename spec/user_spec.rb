require 'spec_helper'

describe Hypem::User do
  let(:user) { Hypem::User.new('jackca') }

  it "initializes with a name parameter" do
    user.instance_variable_get(:@name).should_not be_nil
  end

  it "throws an error with an invalid username" do
    expect { Hypem::User.new(:not_a_string) }.to raise_error(ArgumentError)
  end

  it "gets a loved playlist" do
    VCR.use_cassette('loved_playlist') do
      user.loved_playlist.should be_a Hypem::Playlist
    end
  end

  it "gets an obsessed playlist" do
    VCR.use_cassette('obsessed_playlist') do
      user.obsessed_playlist.should be_a Hypem::Playlist
    end
  end

  it "gets a feed playlist" do
    VCR.use_cassette('feed_playlist') do
      user.feed_playlist.should be_a Hypem::Playlist
    end
  end

  it "gets friends' playlist" do
    VCR.use_cassette('friends_playlist') do
      user.friends_favorites_playlist.should be_a Hypem::Playlist
    end
  end

  it "gets a friends' history playlist" do
    VCR.use_cassette('friends_history') do
      user.friends_history_playlist.should be_a Hypem::Playlist
    end
  end

end
