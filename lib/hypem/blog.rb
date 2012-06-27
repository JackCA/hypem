module Hypem
  class Blog
    include Helper

    attr_reader :blog_image, :blog_image_small, :first_posted,
                :followers, :last_posted, :site_name, :site_url,
                :total_tracks, :id

    convert_keys(siteid: :id, sitename: :site_name, siteurl: :site_url)
    convert_datetimes(:first_posted, :last_posted)

    def initialize(*args)
      if args.count == 1
        @id = args.first.is_a?(Integer) ? args.first : args.first.to_i
      end
    end

    def get_info
      response = Request.get_resource("/get_site_info?siteid=#{id}")
      update_from_response(response)
      self
    end

    def self.all
      response = Request.get_resource("/get_all_blogs")
      response.map { |b| self.new.tap {|blog| blog.update_from_response(b) } }
    end
  end
end
