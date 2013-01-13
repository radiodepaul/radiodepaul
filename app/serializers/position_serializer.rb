class PositionSerializer < ActiveModel::Serializer
  attributes :id, :title, :email, :phone, :office_hours, :person_id
end
