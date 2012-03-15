require 'multi_json'

module Hypem
  class Response
    attr_accessor :body

    def initialize(raw_response)
      raise ArgumentError if raw_response.nil?
      # raise on body error here
      @body = MultiJson.decode raw_response.body
      # getting rid of version cell
      @body.shift
    end

  end
end
