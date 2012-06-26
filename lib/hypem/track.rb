module Hypem
  class Track
    attr_accessor :media_id

    def initialize(arg)
      if arg.is_a? Hash
        keys_to_attributes arg
      elsif arg.is_a? String
        @media_id = arg
      else
        raise
      end
    end

    def get
      response = Request.get_data("/playlist/item/#{media_id}")
      raise if response.is_a? Array
      keys_to_attributes response
      self
    end

    KEY_CONVERSIONS = {
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
    }

    DATETIME_CONVERSIONS = [:date_posted, :date_posted_first]

    private

    def keys_to_attributes(raw_hash)
      raw_hash.each_pair do |key,value|
        converted_key = KEY_CONVERSIONS[key.to_sym]
        key = converted_key unless converted_key.nil?

        value = Time.at(value).to_datetime if DATETIME_CONVERSIONS.include? key
        instance_variable_set("@#{key}",value)

        self.class.class_eval { attr_reader key }
      end
    end

  end
end
