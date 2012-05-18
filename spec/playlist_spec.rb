require 'spec_helper'

describe Hypem::Playlist do
  let(:playlist) do
    VCR.use_cassette('latest_playlist'){Hypem::Playlist.latest}
  end
  
  let(:blog_playlist) do
    VCR.use_cassette('blog_playlist'){Hypem::Playlist.blog(1)}
  end
  
  context "when initialized" do
    
    it "assigns the path attribute" do
      playlist.path.should == "/playlist/time/today/json/1"
    end

    it "assigns proper path for blog" do
      blog_playlist.path.should == "/playlist/blog/1/json/1"
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

  describe ".create" do
    let(:tracks) {[mock('Hypem::Track',id: 'track1',), mock('Hypem::Track',id:'track2')]}

    it "requires an array of tracks" do
      expect { Hypem::Playlist.create_url(['not_a_track'])}.to raise_error ArgumentError
    end

    it "returns the correct playlist url " do
      tracks.first.stub(:is_a?).and_return(true)
      Hypem::Playlist.create_url(tracks).should == 'http://hypem.com/playlist/set/track1,track2/json/1'
    end
  end

  describe ".latest" do
    it "returns a playlist" do
      playlist.should be_a Hypem::Playlist
    end
  end

  describe ".popular" do
    before {Hypem::Playlist.stub_chain(:new, :get)}

    it "converts strings to symbols" do
      Hypem::Playlist.should_receive(:new).with(:popular,%s(3day))
      Hypem::Playlist.popular('3day')
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

  context "class methods" do
    before {Hypem::Playlist.stub_chain(:new, :get)}
    
    describe ".blog" do  
      it "calls new with type blog" do
        Hypem::Playlist.should_receive(:new).with(:blog,1,5)
        Hypem::Playlist.blog(1,5)
      end
    end
  
    describe ".tags" do
      it "creates a tag playlist from a string" do
        Hypem::Playlist.should_receive(:new).with(:tags,'tag1,tag2',5)
        Hypem::Playlist.tags('tag1,tag2',5)
      end
      it "creates a tag playlist from an array of strings" do
        Hypem::Playlist.should_receive(:new).with(:tags,'tag1,tag2',5)
        Hypem::Playlist.tags(['tag1','tag2'],5)
      end
    end
  
    describe ".search" do
      it "calls new with type search" do
        Hypem::Playlist.should_receive(:new).with(:search,'query',5)
        Hypem::Playlist.search('query',5)
      end
    end
  
    describe ".artist" do
      it "calls new with type artist" do
        Hypem::Playlist.should_receive(:new).with(:artist,'name',5)
        Hypem::Playlist.artist('name',5)
      end
    end
  end
  
  describe "pagination" do
    before do
      playlist
      Hypem::Playlist.stub_chain(:new,:get)
    end

    describe "#next_page" do
      it "gets next page" do
        Hypem::Playlist.should_receive(:new).with(anything,anything,2)
        playlist.next_page
      end
    end

    describe "#prev_page" do
      it "gets previous page" do
        Hypem::Playlist.should_receive(:new).with(anything,anything,0)
        playlist.prev_page
      end
    end

    describe "#page" do
      it "gets any page number" do
        Hypem::Playlist.should_receive(:new).with(anything,anything,5)
        playlist.page(5)
      end
    end

  end

end
