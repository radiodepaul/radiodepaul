class EventSerializer < ActiveModel::Serializer
  attributes :id, :title, :first_line, :second_line, :description, :location
end
