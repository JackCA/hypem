require 'faraday'
require 'multi_json'

module Hypem
  module Request

    def self.get(url)
      parse_response connection.get(url+'/json').body
    end
    
    private
    
    def self.connection
      @conn ||= Faraday.new(url: 'http://hypem.com') do |builder|
        builder.request :url_encoded
        builder.response :logger
        builder.adapter :net_http
      end
    end

    def self.parse_response(response)
      MultiJson.decode response
    end

  end

end
