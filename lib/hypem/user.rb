module Hypem
  class User
    include Helper

    convert_keys fullname: :full_name, userpic: :image_url, joined_ts: :joined_at
    convert_datetimes :joined_at

    attr_reader :name, :full_name, :joined_at, :location, :twitter_username, :image_url,
                :followed_users_count, :followed_items_count, :followed_sites_count,
                :followed_queries_count, :friends

    def initialize(name)
      raise ArgumentError unless name.is_a? String
      @name = name
    end


    def get_profile
      response = get_resource('/get_profile')
      flattened_response = flatten_response(response)
      update_from_response(response)
      self
    end

    def favorite_blogs
      response = get_resource('/get_favorite_blogs')

      response.map do |r|
        blog = Hypem::Blog.new(r['siteid'])
        blog.update_from_response(r)
        blog
      end
    end

    def friends
      response = get_resource('/get_friends')

      response.map do |r|
        user = User.new(r['username'])
        user.update_from_response(r)
        user
      end
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

    private

    def flatten_response(response)
      count_hash = response.delete('favorites_count')
      count_hash.each do |k,v|
        pluralized_key = k == 'query' ? 'queries' : k + 's'
        response["followed_#{pluralized_key}_count"] = v
      end
      response
    end

    def get_resource(resource)
      Request.get_resource("#{resource}?username=#{@name}")
    end
  end
end
