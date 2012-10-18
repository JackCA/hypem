require 'spec_helper'
require 'timecop'

describe Hypem::TrackFavorites do
  
  let(:media_id) { '1jsw9' }
  let(:track_favorites_from_string) { described_class.new(media_id) }

  describe "#get" do
    subject do

      # Fetching the last request date, so the timestamp in the request match,
      # and VCR doesn't try to fetch a new episode
      @last_request_time = VCR::Cassette.new("track_favorites").serializable_hash.values.first.last["recorded_at"]
      
      Timecop.freeze(@last_request_time) do
        VCR.use_cassette("track_favorites") do
          track_favorites_from_string.get
        end
      end
    end
    
    its(:users) { should be_a Array }    
  end
  
  
  
end
