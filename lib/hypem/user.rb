module Hypem
  class User
    attr_reader :full_name, :joined_at, :location, :twitter_username, :image_url,
                :followed_users_count, :followed_items_count, :followed_sites_count,
                :followed_queries_count

    def initialize(name)
      raise ArgumentError unless name.is_a? String
      @name = name
    end

    def get_profile
      response = Request.new("/api/get_profile?username=#{@name}").get.response.body
      @full_name = response['fullname']
      @joined_at = Time.at response['joined_ts']
      @location = response['location']
      @twitter_username = response['twitter_username']
      @image_url = response['userpic']
      @followed_users_count = response['favorites_count']['user']
      @followed_items_count = response['favorites_count']['item']
      @followed_sites_count = response['favorites_count']['site']
      @followed_queries_count = response['favorites_count']['query']
      return self
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
