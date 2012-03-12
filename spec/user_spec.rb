require 'hypem'

describe Hypem::User do
  let(:user) { Hypem::User.new('jackca') }

  it "initializes with a user parameter" do
    user.instance_variable_get(:@user).should_not be_nil
  end

  it "throws an error with an invalid username" do
    expect { Hypem::User.new(:not_a_string) }.to raise_error(ArgumentError)
  end

  it "gets a loved playlist" do
    user.loved_playlist.should_not be_nil
  end

  it "gets a feed playlist" do
    user.feed_playlist.should_not be_nil
  end

  it "gets friends' playlist" do
    user.friends_playlist.should_not be_nil
  end

  it "gets a friends' history playlist" do
    user.friends_history.should_not be_nil
  end

end
