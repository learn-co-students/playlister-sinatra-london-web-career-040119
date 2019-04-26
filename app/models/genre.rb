class Genre < ActiveRecord::Base
  has_many :albums
  has_many :song_genres
  has_many :artists, through: :albums
  has_many :songs, through: :song_genres

  def slug
    self.name.gsub(/[" "]/, "-").downcase
  end

  def self.find_by_slug(slug)
    self.all.select {|genre| genre.slug == slug}[0]
  end

end
