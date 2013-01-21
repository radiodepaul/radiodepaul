require 'active_model/serializer'

class ApplicationSerializer < ActiveModel::Serializer
  root(false)

  def decorated
    @decorated ||= object.decorate
  end
end
