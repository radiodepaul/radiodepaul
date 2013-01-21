class NewsPostSerializer < ActiveModel::Serializer
  attributes :id, :headline, :author, :content, :datetime_published, :html, :snippet
end
