require 'httparty'

module Hypem
  class Request
    include HTTParty

    debug_output
    base_uri 'http://api.hypem.com'
    headers 'Accept' => 'text/html'
    format :json

    def self.get_resource(path, query=nil)
      get('/api' + path, query: query)
    end

    def self.get_data(path, page=1)
      url = [path, 'json', page].join('/')
      response = get(url)
      response.delete("version")
      values = response.values
      values.size == 1 ? values.first : values
    end

  end
end
