module Hypem
  class User

    def initialize(name)
      raise ArgumentError unless name.is_a? String
      @name = name
    end

    def profile
      Request.new("/api/get_profile?username=#{@name}").get.response.body
    end

    #playlist requests

    def loved_playlist
      Playlist.loved(@name)
    end

    def obsessed_playlist
      Playlist.obsessed(@name)
    end

    def feed_playlist
      Playlist.feed(@name)
    end

    def friends_favorites_playlist
      Playlist.friends_favorites(@name)
    end

    def friends_history_playlist
      Playlist.friends_history(@name)
    end

  end
end
