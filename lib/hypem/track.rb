require 'hashie'

module Hypem

  class Track < Hashie::Trash
    property :media_id, from: :mediaid
    property :artist
    property :title
    property :date_posted, from: :dateposted
    property :site_id, from: :siteid
    property :sitename
    property :post_url, from: :posturl
    property :post_url_first, from: :posturl_first
    property :post_id, from: :postid
    property :date_posted_first, from: :dateposted_first
    property :site_id_first, from: :siteid_first
    property :site_name_first, from: :sitename_first
    property :post_id_first, from: :postid_first
    property :loved_count
    property :posted_count
    property :thumb_url
    property :thumb_url_large
    property :time
    property :description
    property :itunes_link
    property :date_played, from: :dateplayed
    property :date_loved, from: :dateloved
    property :user_name, from: :username
    property :full_name, from: :fullname
    property :via_query
    property :plays #used by obsessed playlist

  end

end
