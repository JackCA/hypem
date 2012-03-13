require 'faraday'

module Hypem
  class Request
    attr_accessor :response
    attr_reader :url

    def initialize(url, options={})
      @page = options[:page] || 1
      @url = url+"/json/#{@page}"
    end

    def get
      raw_response = connection.get(@url)
      @response = Response.new(raw_response)
      return self
    end

    private
    
    def connection
      @@conn ||= Faraday.new(url: 'http://hypem.com') do |builder|
        builder.request :url_encoded
        builder.response :logger
        builder.use VCR::Middleware::Faraday
        builder.adapter :net_http
      end
    end
  end
end
