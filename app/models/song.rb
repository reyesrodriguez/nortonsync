class Song < ActiveRecord::Base

has_many :taggings
has_many :tags, through: :taggings
belongs_to :user

 
has_many :favorite_songs 
has_many :favorited_by, through: :favorite_songs, source: :user

	require 'csv'
   

	

def self.search(search)
  where("artist ILIKE ? OR title ILIKE ? OR writer ILIKE ? OR publishing ILIKE ? OR theme ILIKE ? OR catalogue ILIKE ?","%#{search}%", "%#{search}%","%#{search}%", "%#{search}%","%#{search}%","%#{search}%").order("artist asc")

end


def self.import(file)
 
	CSV.foreach(file, :headers => true, encoding:'iso-8859-1:utf-8') do |row|	
  Song.create!(row.to_hash)
  end
end

def all_tags=(names)
  self.tags = names.split(",").map do |name|
      Tag.where(name: name.strip).first_or_create!
  end
end

def all_tags
  self.tags.map(&:name).join(", ")
end

def self.tagged_with(name)
  Tag.find_by_name!(name).songs
end


end