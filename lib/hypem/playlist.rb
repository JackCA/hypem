module Hypem
  class Playlist
    attr_accessor :tracks
    def initialize(response)
      raise ArgumentError unless response.is_a? Hash
      response.shift
      @tracks = []
      response.each_value{|v| @tracks << Track.new(v)}
    end

    def self.get(route, user = nil)
      url = ['playlist',route,user].join('/')
      self.new Request.get(url)
    end
  end
end
