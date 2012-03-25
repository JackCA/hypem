require 'hashie'

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
      response = Request.new("/api/get_site_info?siteid=#{@id}").get.response.body
      update_from_response(response)
      return self
    end

    def update_from_response(response)
      @blog_image ||= response['blog_image']
      @blog_image_small ||= response['blog_image_small']
      @followers ||= response['followers']
      @first_posted ||= Time.at(response['first_posted'])
      @id ||= response['siteid']
      @last_posted ||= Time.at(response['last_posted'])
      @site_name ||= response['sitename']
      @site_url ||= response['siteurl']
      @total_tracks ||= response['total_tracks']

    end
  end
end
