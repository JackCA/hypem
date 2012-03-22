require 'spec_helper'

describe Hypem::Playlist do
  let(:playlist) do
    VCR.use_cassette('latest_playlist'){Hypem::Playlist.latest}
  end
  
  let(:blog_playlist) do
    VCR.use_cassette('blog_playlist'){Hypem::Playlist.blog(1)}
  end
  
  
  context "when initialized" do
    
    it "assigns the url attribute" do
      playlist.url.should == "playlist/time/today"
    end

    it "assigns proper url for blog" do
      blog_playlist.url.should == "playlist/blog/1"
    end

  end

  describe "after get" do

    it "should be a playlist" do
      playlist.should be_a Hypem::Playlist
    end

    describe "tracks" do
      it "should assign tracks attribute" do
        playlist.tracks.should_not be_nil
      end
    end
  end

  describe ".latest" do
    
    
    
    it "returns a playlist" do
      playlist.should be_a Hypem::Playlist
    end
  end

  describe ".popular" do
    it "returns a playlist" do
      Hypem::Playlist.popular.should be_a Hypem::Playlist
    end

    describe "parameters" do
      before do
        Hypem::Playlist.any_instance.stub(:get)
      end

      it "retrieves 3day by default" do
        Hypem::Playlist.should_receive(:new).with(:popular,%s(3day))
        Hypem::Playlist.popular
      end

      it "accepts lastweek" do
        Hypem::Playlist.should_receive(:new).with(:popular,:lastweek)
        Hypem::Playlist.popular(:lastweek)
      end

      it "accepts noremix" do
        Hypem::Playlist.should_receive(:new).with(:popular,:noremix)
        Hypem::Playlist.popular(:noremix)
      end

      it "accepts artists" do
        Hypem::Playlist.should_receive(:new).with(:popular,:artists)
        Hypem::Playlist.popular(:artists)
      end

      it "accepts twitter" do
        Hypem::Playlist.should_receive(:new).with(:popular,:twitter)
        Hypem::Playlist.popular(:twitter)
      end

      it "rejects anything else" do
        expect {Hypem::Playlist.popular(:no_no)}.to raise_error(ArgumentError)
      end
    end
  end

  context "class methods" do
    before {Hypem::Playlist.stub_chain(:new, :get)}
    
    describe ".blog" do  
      it "calls new with type blog" do
        Hypem::Playlist.should_receive(:new).with(:blog,1)
        Hypem::Playlist.blog(1)
      end
    end
  
    describe ".tags" do
      it "calls new with type tags" do
        Hypem::Playlist.should_receive(:new).with(:tags,'tag')
        Hypem::Playlist.tags('tag')
      end
    end
  
    describe ".search" do
      it "calls new with type search" do
        Hypem::Playlist.should_receive(:new).with(:search,'query')
        Hypem::Playlist.search('query')
      end
    end
  
    describe ".artist" do
      it "calls new with type artist" do
        Hypem::Playlist.should_receive(:new).with(:artist,'name')
        Hypem::Playlist.artist('name')
      end
    end
  end
  
  describe "pagination" do
    before do
      playlist
      Hypem::Playlist.stub_chain(:new,:get)
    end

    it "can get next page" do
      Hypem::Playlist.should_receive(:new).with(:time,:today,2)
      playlist.next_page
    end

    it "also gets previous page" do
      Hypem::Playlist.should_receive(:new).with(:time,:today,0)
      playlist.prev_page
    end

  end

end
