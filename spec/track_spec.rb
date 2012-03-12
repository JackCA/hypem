require 'spec_helper'

describe Hypem::Track do
  let(:track_hash) do
    VCR.use_cassette('popular_playlist') { Hypem::Playlist.get('popular') }.tracks.first
  end

  let(:track) { Hypem::Track.new(track_hash) }

  it "is reformats variable names" do
    track.media_id.should_not be_nil
  end

end
