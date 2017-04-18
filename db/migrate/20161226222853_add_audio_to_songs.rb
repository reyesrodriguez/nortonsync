class AddAudioToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :audio, :string
  end
end
