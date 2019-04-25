class Artist < ActiveRecord::Base
  has_many :songs
  has_many :albums
  has_many :genres, through: :albums

  def slug
    self.name.gsub(/[" "]/, "-").downcase
  end

  def self.find_by_slug(slug)
    self.all.select {|artist| artist.slug == slug}[0]
  end

end
