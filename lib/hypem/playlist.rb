module Hypem
  class Playlist
    POPULAR_ARGS = [%s(3day),:lastweek,:noremix,:artists,:twitter]
    attr_accessor :path, :tracks
    attr_reader :extended

    def initialize(type,arg,page=nil)
      page = 1 if page.nil?
      @type = type
      @arg = arg
      @page = page
      @path = "/playlist/#{@type}/#{@arg}"
    end

    def get
      response = Request.get_data(path)
      @tracks ||= []
      response.each{|v| tracks << Track.new(v)}
      self
    end

    def next_page
      Playlist.new(@type,@arg,@page+1).get
    end

    def prev_page
      Playlist.new(@type,@arg,@page-1).get
    end

    def page(num)
      Playlist.new(@type,@arg,num).get
    end

    def self.new_from_tracks(tracks)
      track_params = tracks.map(&:id).join(',')
      Playlist.new('set',track_params).tap { |p| p.tracks = tracks }
    end

    def self.latest(filter=:all,page=nil)
      raise ArgumentError unless [:all, :noremix, :remix, :fresh].include? filter
      Playlist.new(:latest,filter,page).get
    end

    def self.popular(arg=POPULAR_ARGS.first,page=nil)
      arg = arg.to_sym if arg.is_a? String
      raise ArgumentError unless POPULAR_ARGS.include?(arg)
      Playlist.new(:popular,arg,page).tap(&:get)
    end

    def self.friends_history(user,page=nil)
      Playlist.new(:people_history,user,page)
    end

    def self.friends_favorites(user,page=nil)
      Playlist.new(:people,user,page)
    end

    def self.tags(list,page)
      list = list.join(',') if list.is_a? Array
      Playlist.new(:tags,list,page)
    end
    

    GENERIC_METHODS = [:blog, :search, :artist, :feed, :loved, :obsessed]
    # meta method definitions for generic playlists
    GENERIC_METHODS.each do |method|
      define_singleton_method(method) do |arg,page=nil|
        Playlist.new(method,arg,page)
      end
    end

  end
end
