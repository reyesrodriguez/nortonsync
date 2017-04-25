class CreateFavoriteSongs < ActiveRecord::Migration
  def change
    create_table :favorite_songs do |t|
      t.belongs_to :song, index: true, foreign_key: true
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
