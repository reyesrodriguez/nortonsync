class AddAudiourlToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :audiourl, :string
  end
end
