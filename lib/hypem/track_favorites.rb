module Hypem
  class TrackFavorites
    include Helper
    
    attr_accessor :users, :media_id
    
    LIMIT = 20
    
    def initialize(media_id, page=nil)
      page = 1 if page.nil?
      @media_id = media_id
      @page = page
    end
    
    def get
      user_ids = TrackFavoritesRequest.get_data(path)
      @users = user_ids.map{|user_id| User.new(user_id)}
      self
    end
    
    def next_page
      TrackFavorites.new(@media_id,@page+1).get
    end

    def prev_page
      TrackFavorites.new(@media_id,@page+1).get
    end

    def page(num)
      TrackFavorites.new(@media_id,num).get
    end

    private
    
    def path
      timestamp = Time.now.to_i
      items_to_skip = (@page - 1)*LIMIT

      return "/serve_activity_info.php?" + [
        "type=favorites",
        "id=#{media_id}",
        "skip=#{items_to_skip}",
        "limit=#{LIMIT}",
        "ts=#{timestamp}"
      ].join("&")
    end
    
  end
end