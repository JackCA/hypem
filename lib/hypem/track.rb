module Hypem
  class Track
    include Helper

    attr_accessor :media_id

    convert_keys(
      mediaid: :media_id,
      dateposted: :dated_posted,
      siteid: :site_id,
      posturl: :post_url,
      posturl_first: :post_url_first,
      postid: :post_id,
      postid_first: :post_id_first,
      dateposted_first: :date_posted_first,
      siteid_first: :site_id_first,
      sitename: :site_name,
      dateposted: :date_posted,
      sitename_first: :site_name_first
    )

    convert_datetimes :date_posted, :date_posted_first

    def initialize(arg)
      if arg.is_a? Hash
        update_from_response arg
      elsif arg.is_a? String
        @media_id = arg
      else
        raise
      end
    end

    def get
      response = Request.get_data("/playlist/item/#{media_id}")
      update_from_response response
      self
    end

    def favorites(page=nil)
      @track_favorites ||= TrackFavorites.new(@media_id)
    end

  end
end
