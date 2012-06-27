require 'spec_helper'

describe Hypem::User do
  let(:user) { Hypem::User.new('jackca') }
  subject { user }

  its(:name) { should_not be_nil }

  it "throws an error with an invalid username argument" do
    expect { Hypem::User.new(:not_a_string) }.to raise_error(ArgumentError)
  end

  describe "#loved_playlist" do
    specify do
      Hypem::Playlist.should_receive(:loved).with(subject.name,anything)
      subject.loved_playlist
    end
  end

  describe "#obsessed_playlist" do
    specify do
      Hypem::Playlist.should_receive(:obsessed).with(subject.name,anything)
      subject.obsessed_playlist
    end
  end

  describe "#feed_playlist" do
    specify do
      Hypem::Playlist.should_receive(:feed).with(subject.name,anything)
      subject.feed_playlist
    end
  end

  describe "#friends_favorites_playlist" do
    specify do
      Hypem::Playlist.should_receive(:friends_favorites).with(subject.name,anything)
      subject.friends_favorites_playlist
    end
  end

  describe "#friends_history_playlist" do
    specify do
      Hypem::Playlist.should_receive(:friends_history).with(subject.name,anything)
      subject.friends_history_playlist
    end
  end

  describe "#get_profile" do
    let(:user_with_profile) do
      VCR.use_cassette('user_profile') {user.get_profile}
    end

    subject {user_with_profile}

    its(:full_name) {should == "Jack Anderson"}
    its(:joined_at) {should be_a DateTime}
    its(:location) {should == 'San Francisco, CA, US'}
    its(:twitter_username) {should == 'janderson'}
    its(:image_url) {should == 'http://faces-s3.hypem.com/123376863051420_75.png'}
    its(:followed_users_count) {should be_an Integer}
    its(:followed_items_count) {should be_an Integer}
    its(:followed_sites_count) {should be_an Integer}
    its(:followed_queries_count) {should be_an Integer}
  end

  describe "#friends" do
    let(:user_with_friends) do
      VCR.use_cassette('user_friends') {user.friends}
    end

    subject {user_with_friends}

    it {should be_an Array}

    it "be an array of users" do
      subject.first.should be_a Hypem::User
    end
  end

  describe "#favorite_blogs" do
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
