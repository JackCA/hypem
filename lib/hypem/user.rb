module Hypem
  class User

    def initialize(name)
      raise ArgumentError unless name.is_a? String
      @name = name
    end

    def loved_playlist
      Playlist.get(:loved,@name)
    end

    def feed_playlist
      Playlist.get(:feed,@name)
    end

    def friends_playlist
      Playlist.get(:people,@name)
    end

    def friends_history
      Playlist.get(:people_history,@name)
    end

  end
end
