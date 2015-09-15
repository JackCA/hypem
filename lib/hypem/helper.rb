module Hypem
  module Helper

    def self.included(base)
      base.extend(ClassMethods)
    end

    def update_from_response(raw_hash)
      # Remixes in particular can return multiple hashes...
      # For our purposes, let's just use the first?
      response_hash = raw_hash.kind_of?(Array) ? raw_hash.first : raw_hash

      response_hash.each_pair do |key,value|
        key = self.class.key_conversions[key.to_sym] || key.to_sym

        if self.class.datetime_conversions.andand.include? key
          value = Time.at(value).to_datetime 
        end

        instance_variable_set("@#{key}",value)

        self.class.class_eval { attr_reader key }
      end
    end

    module ClassMethods
      attr_reader :key_conversions, :datetime_conversions

      def convert_keys(values)
        @key_conversions = values
      end

      def convert_datetimes(*values)
        @datetime_conversions = values
      end
    end

  end
end
