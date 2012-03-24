module Hypem
  class Playlist
    POPULAR_ARGS = [%s(3day),:lastweek,:noremix,:artists,:twitter]
    GENERIC_METHODS = [:blog, :tags, :search, :artist, :feed, :loved, :obsessed]
    attr_accessor :url, :tracks
    attr_reader :extended

    def initialize(type,arg,page=1)
      @type = type
      @arg = arg
      @url = ['playlist',type,arg].join('/')
      @page = page
    end

    def get
      response = Request.new(url,page: @page).get.response
      @tracks = []
      response.body.each_value{|v| @tracks << Track.new(v)}
      return self
    end

    def next_page
      Playlist.new(@type,@arg,@page+1).get
    end

    def prev_page
      Playlist.new(@type,@arg,@page-1).get
    end

    def self.latest
      Playlist.new(:time,:today).get
    end

    def self.popular(arg=POPULAR_ARGS.first)
      arg = arg.to_sym if arg.is_a? String
      raise ArgumentError unless POPULAR_ARGS.include?(arg)
      Playlist.new(:popular,arg).get
    end

    def self.friends_history(user)
      Playlist.new(:people_history,user).get
    end

    def self.friends_favorites(user)
      Playlist.new(:people,user).get
    end

    # meta method definitions for generic playlists
    GENERIC_METHODS.each do |method|
      define_singleton_method(method) {|arg| Playlist.new(method,arg).get }
    end

  end
end
