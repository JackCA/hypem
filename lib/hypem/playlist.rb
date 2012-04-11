module Hypem
  class Playlist
    POPULAR_ARGS = [%s(3day),:lastweek,:noremix,:artists,:twitter]
    GENERIC_METHODS = [:blog, :search, :artist, :feed, :loved, :obsessed]
    attr_accessor :path, :tracks
    attr_reader :extended

    def initialize(type,arg,page=1)
      @type = type
      @arg = arg
      @page = page
      @path = "/playlist/#{@type}/#{@arg}/json/#{@page}"
    end

    def get
      response = Request.new(@path).get.response
      @tracks = []
      # getting rid of version cell
      response.body.shift
      response.body.each_value{|v| @tracks << Track.new(v)}
      return self
    end

    def next_page
      Playlist.new(@type,@arg,@page+1).get
    end

    def prev_page
      Playlist.new(@type,@arg,@page-1).get
    end

    def self.create_url(tracks)
      raise ArgumentError if (!tracks.is_a? Array) || (!tracks.first.is_a? Hypem::Track)
      track_params = tracks.map(&:id).join(',')
      playlist = Playlist.new('set',track_params)
      return Hypem::ROOT_PATH + playlist.path
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

    def self.tags(input)
      input = input.join(',') if input.is_a? Array
      Playlist.new(:tags,input)
    end
    

    # meta method definitions for generic playlists
    GENERIC_METHODS.each do |method|
      define_singleton_method(method) {|arg| Playlist.new(method,arg).get }
    end

  end
end
