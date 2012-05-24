require 'spec_helper'

describe Hypem::Response do

  context "at initialization" do
    let(:request) do
      Hypem::Request.new('/playlist/latest/fresh/json/1')
    end

    let(:gotten_request) do
      VCR.use_cassette('fresh_playlist') do
        request.get
      end
    end

    let(:response) do
      described_class.new(gotten_request)
    end

    it "uses a raw response parameter" do
      response.body.should_not be_nil
    end

    it "assigns the body attribute" do
      response.body.should be_a Hash
    end

    it "raises RequestError with null body" do
      raw_response = double('RawResponse')
      raw_response.stub(:body).and_return('null')
      expect { described_class.new(raw_response) }.to raise_error Hypem::RequestError
    end
  end


end
