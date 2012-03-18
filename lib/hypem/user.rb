module Hypem
  class User

    def initialize(name)
      raise ArgumentError unless name.is_a? String
      @name = name
    end

    def loved_playlist
      Playlist.loved(@name).get
    end

    def obsessed_playlist
      Playlist.obsessed(@name).get
    end

    def feed_playlist
      Playlist.feed(@name).get
    end

    def friends_favorites_playlist
      Playlist.friends_favorites(@name).get
    end

    def friends_history_playlist
      Playlist.friends_history(@name).get
    end

  end
end
