require 'spec_helper'

describe Hypem::Track do
  let(:track_hash) do
    VCR.use_cassette('latest_playlist') do
      Hypem::Request.get('/playlist/latest/all/json/1')["0"]
    end
  end

  let(:media_id) { '1jsw9' }
  let(:track_from_hash) { described_class.new(track_hash) }
  let(:track_from_string) { described_class.new(media_id) }

  shared_examples_for "a basic synced instance" do
    its(:media_id) { should be_a String }
    its(:artist) { should be_a String }
    its(:title) { should be_a String }
    its(:date_posted) { should be_a DateTime }
    its(:site_id) { should be_an Integer }
    its(:site_name) { should be_a String }
    its(:post_url) { should be_a String }
    its(:post_id) { should be_an Integer }
    its(:loved_count) { should be_an Integer }
    its(:posted_count) { should be_an Integer }
    its(:thumb_url) { should be_a String }
    its(:thumb_url_large) { should be_a String }
    its(:time) { should be_an Integer }
    its(:description) { should be_a String }
    its(:itunes_link) { should be_a String }
  end

  shared_examples_for "a detailed synced instance" do
    it_should_behave_like "a basic synced instance"
    its(:post_url_first) { should be_a String }
    its(:post_id_first) { should be_an Integer }
    its(:site_name_first) { should be_a String }
    its(:date_posted_first) { should be_a DateTime }
    its(:site_id_first) { should be_an Integer }
  end

  describe "#initialize" do
    context "from a hash" do
      subject { track_from_hash }
      it_should_behave_like "a detailed synced instance"
    end

    context "from a media_id" do
      subject { track_from_string }
      its(:media_id) { should == media_id }
    end
  end

  describe "#get" do
    subject do
      VCR.use_cassette("single_track") { track_from_string.get }
    end
    it_should_behave_like "a basic synced instance"
  end

end
