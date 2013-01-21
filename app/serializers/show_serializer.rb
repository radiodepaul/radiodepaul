class ShowSerializer < ApplicationSerializer
  attributes :id, :title, :short_description, :long_description, :facebook_page_username, :twitter_username, :website_url, :email, :thumb_url, :small_url, :medium_url, :large_url, :genre_list

  has_many :hosts, serializer: ShortPersonSerializer
  has_many :slots

  def slots
    object.slots.active
  end
end
