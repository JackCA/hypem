module Hypem
  class Playlist
    attr_accessor :url, :tracks
    attr_reader :extended

    def initialize(type,arg)
      @url = ['playlist',type,arg].join('/')
    end

    def get
      response = Request.new(url).get.response
      @tracks = []
      response.body.each_value{|v| @tracks << Track.new(v)}
      return self
    end
    
    def self.latest
      Playlist.new(:time,:today)
    end

    def self.popular(arg='3day')
      Playlist.new(:popular,arg)
    end

    def self.blog(arg)
      Playlist.new(:blog,arg)
    end

    def self.tags(arg)
      Playlist.new(:tags,arg)
    end

    def self.search(arg)
      Playlist.new(:search,arg)
    end

    def self.artist(arg)
      Playlist.new(:artist,arg)
    end
  end
end
