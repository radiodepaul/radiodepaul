class PodcastSerializer < ActiveModel::Serializer
  attributes :id, :title, :type, :description, :contributors, :file_url
end
