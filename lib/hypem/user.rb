module Hypem
  class User
    attr_reader :name, :full_name, :joined_at, :location, :twitter_username, :image_url,
                :followed_users_count, :followed_items_count, :followed_sites_count,
                :followed_queries_count, :friends

    def initialize(name)
      raise ArgumentError unless name.is_a? String
      @name = name
    end

    def get(resource)
      Request.get_resource("#{resource}?username=#{@name}")
    end

    def get_profile
      unless @has_profile
        response = get('/get_profile')
        update_from_response(response)
        @has_profile = true
      end
      return self
    end

    def get_favorite_blogs
      response = get('/get_favorite_blogs')

      response.map do |r|
        blog = Hypem::Blog.new(r['siteid'])
        blog.update_from_response(r)
        blog
      end
    end

    def favorite_blogs
      @favorite_blogs ||= get_favorite_blogs
    end

    def get_friends
      response = get('/get_friends')

      response.map do |r|
        user = User.new(r['username'])
        user.update_from_response(r)
        user
      end
    end

    def friends
      @friends ||= get_friends
    end

    def update_from_response(response)
      @full_name              ||= response['fullname']
      @location               ||= response['location']
      @image_url              ||= response['userpic']
      @followed_users_count   ||= response['favorites_count']['user']
      @followed_items_count   ||= response['favorites_count']['item']
      @followed_sites_count   ||= response['favorites_count']['site']
      @followed_queries_count ||= response['favorites_count']['query']

      # only returned on get_profile
      @joined_at ||= Time.at(response['joined_ts']) unless response['joined_ts'].nil?
      @twitter_username ||= response['twitter_username']
    end

    #playlist requests

    def loved_playlist(page=1)
      @l_p ||= Playlist.loved(@name,page)
    end

    def obsessed_playlist(page=1)
      @o_p ||= Playlist.obsessed(@name,page)
    end

    def feed_playlist(page=1)
      @f_p ||= Playlist.feed(@name,page)
    end

    def friends_favorites_playlist(page=1)
      @f_f_p ||= Playlist.friends_favorites(@name,page)
    end

    def friends_history_playlist(page=1)
      @f_h_p ||= Playlist.friends_history(@name,page)
    end
  end
end
