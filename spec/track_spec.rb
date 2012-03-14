require 'spec_helper'

describe Hypem::Track do
  let(:track_hash) do
    VCR.use_cassette('popular_playlist') do
      Hypem::Playlist.get(:popular, :'3day').tracks.first
    end
  end

  let(:track) { Hypem::Track.new(track_hash) }

  it "is reformats variable names" do
    track.media_id.should_not be_nil
  end

end
