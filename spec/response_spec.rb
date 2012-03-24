require 'spec_helper'

describe Hypem::Response do

  context "at initialization" do
    let(:response) do
      VCR.use_cassette('fresh_playlist') do
        Hypem::Request.new('/playlist/latest/fresh/json/1').get.response
      end
    end

    it "uses a raw response parameter" do
      response.body.should_not be_nil
    end

    it "assigns the body attribute" do
      response.body.should be_a Hash
    end
  end


end
