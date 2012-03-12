module Hypem
  class User

    def initialize(user)
      raise ArgumentError unless user.is_a? String
      @user = user
    end

    def loved_playlist
      Request.get('/playlist/loved/' + @user)
    end

    def feed_playlist
      Request.get('/playlist/feed/' + @user)
    end

    def friends_playlist
      Request.get('playlist/people/' + @user)
    end

    def friends_history
      Request.get('playlist/people_history/' + @user)
    end

  end
end
