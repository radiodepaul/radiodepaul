require 'active_support/concern'

module JSONTools
  module JSONCacheable
    extend ActiveSupport::Concern

    module ClassMethods
      def for_caching
        scoped.select("#{table_name}.*")
      end
    end
  end
end
