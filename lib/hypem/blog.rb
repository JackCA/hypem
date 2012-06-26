module Hypem
  class Blog
    attr_reader :blog_image, :blog_image_small, :first_posted,
                :followers, :last_posted, :site_name, :site_url,
                :total_tracks, :id

    def initialize(*args)
      if args.count == 1
        @id = args.first.is_a?(Integer) ? args.first : args.first.to_i
      end
    end

    def get_info
      unless @has_info
        response = Request.get_resource("/get_site_info?siteid=#{id}")
        update_from_response(response)
        @has_info = true
      end
    end

    def update_from_response(rsp)
      @id ||= rsp[:site_id]
      @blog_image ||= rsp['blog_image']
      @blog_image_small ||= rsp['blog_image_small']
      @followers ||= rsp['followers']
      @id ||= rsp['siteid']
      @site_name ||= rsp['sitename']
      @site_url ||= rsp['siteurl']
      @total_tracks ||= rsp['total_tracks']

      # only from get_info
      @first_posted ||= Time.at(rsp['first_posted']) unless rsp['first_posted'].nil?
      @last_posted ||= Time.at(rsp['last_posted']) unless rsp['last_posted'].nil?

    end

    def self.all
      response = Request.get_resource("/get_all_blogs")
      response.map { |b| self.new.tap {|blog| blog.update_from_response(b) } }
    end
  end
end
