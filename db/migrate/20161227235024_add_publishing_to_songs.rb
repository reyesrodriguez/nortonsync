class AddPublishingToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :publishing, :string
  end
end
