module Hypem
  class User

    def initialize(user)
      raise ArgumentError unless user.is_a? String
      @user = user
    end

    def loved_playlist
      Playlist.get('loved',@user)
    end

    def feed_playlist
      Playlist.get('feed',@user)
    end

    def friends_playlist
      Playlist.get('people',@user)
    end

    def friends_history
      Playlist.get('people_history',@user)
    end

  end
end
