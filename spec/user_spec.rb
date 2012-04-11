require 'spec_helper'

describe Hypem::User do
  let(:user) { Hypem::User.new('jackca') }

  it "initializes with a name parameter" do
    user.instance_variable_get(:@name).should_not be_nil
  end

  it "throws an error with an invalid username argument" do
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

  describe ".get_profile" do
    let(:user_with_profile) do
      VCR.use_cassette('user_profile') {user.get_profile}
    end

    subject {user_with_profile}

    its(:full_name) {should == "Jack Anderson"}
    its(:joined_at) {should == Time.parse('2009-03-29 17:06:55 -0700')}
    its(:location) {should == 'San Francisco, CA, US'}
    its(:twitter_username) {should == 'janderson'}
    its(:image_url) {should == 'http://faces-s3.hypem.com/123376863051420_75.png'}
    its(:followed_users_count) {should == 4}
    its(:followed_items_count) {should == 430}
    its(:followed_sites_count) {should == 32}
    its(:followed_queries_count) {should == 15}
  end

  describe ".friends" do
    let(:user_with_friends) do
      VCR.use_cassette('user_friends') {user.friends}
    end

    subject {user_with_friends}

    it {should be_an Array}

    it "be an array of users" do
      subject.first.should be_a Hypem::User
    end
  end

  describe ".favorite_blogs" do
    let(:user_with_favorite_blogs) do
      VCR.use_cassette('user_favorite_blogs') {user.favorite_blogs}
    end

    subject {user_with_favorite_blogs}

    it {should be_an Array}

    it "should be an array of Blogs" do
      subject.first.should be_a Hypem::Blog
    end
  end

end
