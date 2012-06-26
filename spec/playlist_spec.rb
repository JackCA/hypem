require 'spec_helper'

describe Hypem::Playlist do
  let(:playlist) do
    VCR.use_cassette('latest_playlist'){described_class.latest}
  end
  
  let(:blog_playlist) do
    VCR.use_cassette('blog_playlist'){described_class.blog(1)}
  end

  subject { playlist }

  ########################################
  
  its(:path) { should == "/playlist/latest/all" }
  its(:tracks) { should_not be_empty }

  describe ".new_from_tracks" do
    let(:tracks) {[mock('Hypem::Track',id: 'track1',), mock('Hypem::Track',id:'track2')]}
    subject { Hypem::Playlist.new_from_tracks(tracks) }
    it { should be_a Hypem::Playlist }
    its(:path) { should == '/playlist/set/track1,track2' }
    its(:tracks) { should_not be_empty }
  end

  describe ".latest" do
    specify { playlist.should be_a described_class }
  end

  describe ".popular" do
    before { described_class.stub_chain(:new, :get) }

    it "converts strings to symbols" do
      described_class.should_receive(:new).with(:popular,%s(3day),anything)
      described_class.popular('3day')
    end

    it "retrieves 3day by default" do
      described_class.should_receive(:new).with(:popular,%s(3day),anything)
      described_class.popular
    end

    it "accepts lastweek" do
      described_class.should_receive(:new).with(:popular,:lastweek,anything)
      described_class.popular(:lastweek)
    end

    it "accepts noremix" do
      described_class.should_receive(:new).with(:popular,:noremix,anything)
      described_class.popular(:noremix)
    end

    it "accepts artists" do
      described_class.should_receive(:new).with(:popular,:artists,anything)
      described_class.popular(:artists)
    end

    it "accepts twitter" do
      described_class.should_receive(:new).with(:popular,:twitter,anything)
      described_class.popular(:twitter)
    end

    it "rejects anything else" do
      expect {described_class.popular(:no_no)}.to raise_error(ArgumentError)
    end
  end

  describe ".blog" do  
    before { described_class.stub_chain(:new,:get) }
    it "calls new with type blog" do
      described_class.should_receive(:new).with(:blog,1,5)
      described_class.blog(1,5)
    end
  end

  describe ".tags" do
    before { described_class.stub_chain(:new,:get) }

    it "creates a tag playlist from a string" do
      described_class.should_receive(:new).with(:tags,'tag1,tag2',5)
      described_class.tags('tag1,tag2',5)
    end

    it "creates a tag playlist from an array of strings" do
      described_class.should_receive(:new).with(:tags,'tag1,tag2',5)
      described_class.tags(['tag1','tag2'],5)
    end
  end

  describe ".search" do
    before { described_class.stub_chain(:new,:get) }

    it "calls new with type search" do
      described_class.should_receive(:new).with(:search,'query',5)
      described_class.search('query',5)
    end
  end

  describe ".artist" do
    before { described_class.stub_chain(:new,:get) }

    it "calls new with type artist" do
      described_class.should_receive(:new).with(:artist,'name',5)
      described_class.artist('name',5)
    end
  end

  shared_examples_for "generic method" do
    before do
      Hypem::Playlist.any_instance.stub(:get)
    end
    specify { described_class.send(method,:an_argument).should be_a described_class }
  end

  describe ".blog" do
    let(:method) { :blog }
    it_should_behave_like "generic method"
  end

  describe ".search" do
    let(:method) { :search }
    it_should_behave_like "generic method"
  end

  describe ".artist" do
    let(:method) { :artist }
    it_should_behave_like "generic method"
  end

  describe ".feed" do
    let(:method) { :feed }
    it_should_behave_like "generic method"
  end

  describe ".loved" do
    let(:method) { :loved }
    it_should_behave_like "generic method"
  end

  describe ".obsessed" do
    let(:method) { :obsessed }
    it_should_behave_like "generic method"
  end

  describe "pagination" do
    before do
      playlist
      described_class.stub_chain(:new,:get)
    end

    describe "#next_page" do
      it "gets next page" do
        described_class.should_receive(:new).with(anything,anything,2)
        playlist.next_page
      end
    end

    describe "#prev_page" do
      it "gets previous page" do
        described_class.should_receive(:new).with(anything,anything,0)
        playlist.prev_page
      end
    end

    describe "#page" do
      it "gets any page number" do
        described_class.should_receive(:new).with(anything,anything,5)
        playlist.page(5)
      end
    end
  end

end
