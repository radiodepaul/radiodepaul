require 'active_support/concern'
require 'json_tools/json_encoder'

# This is a duplicate of ActiveRecord::Store, but using JSON, obviously.
module JSONTools
  module JSONStore
    extend ActiveSupport::Concern

    module ClassMethods
      def store(store_attribute, options = {})
        serialize store_attribute, JSONEncoder.new

        if options.has_key? :accessors
          store_accessor(store_attribute, options[:accessors])
        end
      end

      def store_accessor(store_attribute, *keys)
        Array(keys).flatten.each do |key|
          define_method("#{key}=") do |value|
            send(store_attribute)[key.to_s] = value
            send("#{store_attribute}_will_change!")
          end

          define_method(key) do
            send(store_attribute)[key.to_s]
          end
        end
      end
    end
  end
end
