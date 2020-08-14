class RemoveImageUrlFromRestaurants < ActiveRecord::Migration[6.0]
  def change
    remove_column :restaurants, :image_url, :string
  end
end
