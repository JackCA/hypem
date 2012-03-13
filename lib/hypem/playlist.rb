module Hypem
  class Playlist
    attr_accessor :tracks

    def initialize(response)
      raise ArgumentError unless response.is_a? Response
      @tracks = []
      response.body.each_value{|v| @tracks << Track.new(v)}
    end

    def self.get(route, user = nil)
      url = "playlist/#{route}"
      url << "/#{user}" unless user.nil?
      self.new Request.new(url).get.response
    end
  end
end
