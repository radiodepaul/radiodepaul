class Application < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader
  attr_accessible :anything_else, :bio, :campus_involvement, :co_hosts, :depaul_id, :email, :experience, :famous_person, :favorite_artists, :favorite_films, :favorite_tv_shows, :first_name, :gpa, :home_city, :home_state, :host_type, :influences, :last_name, :major, :phone, :podcast_topic, :position, :show_description, :show_genres, :show_name, :show_type, :why_depaul, :year, :avatar, :created_at, :genre_list, :avatar_cache, :remote_avatar_url
  acts_as_taggable_on :genres
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :depaul_id, :presence => true, :numericality => { :only_integer => true }

  def first_last_name
    return self.first_name + ' ' + self.last_name
  end

  def last_first_name
    return self.last_name + ', ' + self.first_name
  end
end
