module Hypem
  class User
    attr_reader :full_name, :joined_at, :location, :twitter_username, :image_url,
                :followed_users_count, :followed_items_count, :followed_sites_count,
                :followed_queries_count, :friends, :favorite_blogs

    def initialize(name)
      raise ArgumentError unless name.is_a? String
      @name = name
    end

    def api_request(path)
      Request.new("/api/#{path}?username=#{@name}").get.response.body
    end

    def get_profile
      response = api_request('get_profile')
      update_from_response(response)
      return self
    end

    def get_favorite_blogs
      response = api_request('get_favorite_blogs')
      @favorite_blogs = response.map do |r|
        blog = Hypem::Blog.new(r['siteid'])
        blog.update_from_response(r)
        blog
      end
      return self
    end

    def get_friends
      response = api_request('get_friends')
      @friends = response.map do |r|
        user = User.new(r['username'])
        user.update_from_response(r)
        user
      end
      return self
    end

    def update_from_response(response)
      @full_name = response['fullname']
      @location = response['location']
      @image_url = response['userpic']
      @followed_users_count = response['favorites_count']['user']
      @followed_items_count = response['favorites_count']['item']
      @followed_sites_count = response['favorites_count']['site']
      @followed_queries_count = response['favorites_count']['query']

      # only returned on get_profile
      @joined_at = Time.at(response['joined_ts']) unless response['joined_ts'].nil?
      @twitter_username = response['twitter_username']
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
