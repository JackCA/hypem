module Hypem
  class TrackFavoritesRequest < Request
    
    base_uri 'http://hypem.com/inc'
    format :html
    
    # Extract the response in a user names enumerator
    def self.get_data(path)
      response = get(path)
      return response.body.scan(/<span>(\w*)<\/span>/).flatten
    end
    
  end
end