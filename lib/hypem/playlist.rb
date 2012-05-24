module Hypem
  class Playlist
    POPULAR_ARGS = [%s(3day),:lastweek,:noremix,:artists,:twitter]
    GENERIC_METHODS = [:blog, :search, :artist, :feed, :loved, :obsessed]
    attr_accessor :path, :tracks
    attr_reader :extended

    def initialize(type,arg,page=nil)
      page = 1 if page.nil?
      @type = type
      @arg = arg
      @page = page
      @path = "/playlist/#{@type}/#{@arg}/json/#{@page}"
    end

    def get
      response = Request.new(@path).tap(&:get).response
      @tracks = []
      # getting rid of version cell
      response.body.shift
      response.body.each_value{|v| @tracks << Track.new(v)}
    end

    def next_page
      Playlist.new(@type,@arg,@page+1).tap(&:get)
    end

    def prev_page
      Playlist.new(@type,@arg,@page-1).tap(&:get)
    end

    def page(num)
      Playlist.new(@type,@arg,num).tap(&:get)
    end

    def self.create_url(tracks)
      raise ArgumentError if (!tracks.is_a? Array) || (!tracks.first.is_a? Hypem::Track)
      track_params = tracks.map(&:id).join(',')
      playlist = Playlist.new('set',track_params)
      return Hypem::ROOT_PATH + playlist.path
    end

    def self.latest(page=nil)
      Playlist.new(:time,:today,page).tap(&:get)
    end

    def self.popular(arg=POPULAR_ARGS.first,page=nil)
      arg = arg.to_sym if arg.is_a? String
      raise ArgumentError unless POPULAR_ARGS.include?(arg)
      Playlist.new(:popular,arg,page).tap(&:get)
    end

    def self.friends_history(user,page=nil)
      Playlist.new(:people_history,user,page).tap(&:get)
    end

    def self.friends_favorites(user,page=nil)
      Playlist.new(:people,user,page).tap(&:get)
    end

    def self.tags(list,page)
      list = list.join(',') if list.is_a? Array
      Playlist.new(:tags,list,page)
    end
    

    # meta method definitions for generic playlists
    GENERIC_METHODS.each do |method|
      define_singleton_method(method) do |arg,page=nil|
        Playlist.new(method,arg,page).tap(&:get)
      end
    end

  end
end
