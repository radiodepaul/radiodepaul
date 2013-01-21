class AwardSerializer < ActiveModel::Serializer
  attributes :id, :name, :for, :year, :award_organization_name, :award_organization_url
end
