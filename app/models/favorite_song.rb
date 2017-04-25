class FavoriteSong < ActiveRecord::Base
  belongs_to :song
  belongs_to :user
end
