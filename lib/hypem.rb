require "hypem/response"
require "hypem/request"
require "hypem/user"
require "hypem/track"
require "hypem/playlist"
require "hypem/blog"
require "exceptions"

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

