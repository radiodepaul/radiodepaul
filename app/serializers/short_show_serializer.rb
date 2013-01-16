class ShortShowSerializer < ApplicationSerializer
  attributes :id, :title, :short_description, :thumb_url, :genre_list

  has_many :hosts, serializer: ShortPersonSerializer
end
