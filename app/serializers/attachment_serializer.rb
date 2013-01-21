class AttachmentSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :contributors, :file_url
end
