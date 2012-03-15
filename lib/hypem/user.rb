module Hypem
  class User

    def initialize(name)
      raise ArgumentError unless name.is_a? String
      @name = name
    end

    def loved_playlist
      Playlist.new(:loved,@name).get
    end

    def feed_playlist
      Playlist.new(:feed,@name).get
    end

    def friends_playlist
      Playlist.new(:people,@name).get
    end

    def friends_history
      Playlist.new(:people_history,@name).get
    end

  end
end
