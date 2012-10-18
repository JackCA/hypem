require "andand"
require "hypem/helper"
require "hypem/request"
require "hypem/user"
require "hypem/track"
require "hypem/playlist"
require "hypem/blog"
require "hypem/exceptions"

require "hypem/track_favorites_request"
require "hypem/track_favorites"


module Hypem

  #convenient way of accessing module classes
  def self.method_missing(method, *args)
    method_name = method.capitalize
    raise ArgumentError unless self.const_defined? method_name
    if args.empty?
      self.const_get(method_name)
    else
      self.const_get(method_name).send(:new, *args)
    end
  end

end

