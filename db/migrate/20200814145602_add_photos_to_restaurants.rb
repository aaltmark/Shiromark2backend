class AddPhotosToRestaurants < ActiveRecord::Migration[6.0]
  def change
    add_column :restaurants, :photos, :text, array: true, default: [], null: false
    add_column :restaurants, :tags, :string, array: true, default: [], null: false
  end
end
