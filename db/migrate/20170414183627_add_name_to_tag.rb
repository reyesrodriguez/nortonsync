class AddNameToTag < ActiveRecord::Migration
  def change
    add_column :tags, :nam, :string
  end
end
