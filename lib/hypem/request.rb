require 'faraday'

module Hypem
  ROOT_PATH = 'http://hypem.com'
  class Request
    attr_accessor :response
    attr_reader :url

    def initialize(url)
      @url = url
    end

    def get
      raw_response = connection.get(@url)
      @response = Response.new(raw_response)
      return self
    end

    private
    
    def connection
      @@conn ||= Faraday.new(url: ROOT_PATH) do |builder|
        builder.request :url_encoded
        #builder.response :logger
        builder.adapter :net_http
      end
    end
  end
end
