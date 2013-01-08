require 'active_support/concern'

module Randomizable
  extend ActiveSupport::Concern

  module ClassMethods
    def random(limit=1)
      ids = self.find( :all, :select => 'id' ).map( &:id )
      self.find( (1..limit).map { ids.delete_at( ids.size * rand ) } )
    end
  end
end
