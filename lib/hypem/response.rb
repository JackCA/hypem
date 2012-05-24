require 'multi_json'

module Hypem
  class Response
    attr_accessor :body

    def initialize(raw_response)
      raise RequestError if raw_response.body == 'null'

      @body = MultiJson.decode raw_response.body
    end

  end
end
