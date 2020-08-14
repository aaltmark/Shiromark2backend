class AddPriceToRestaurants < ActiveRecord::Migration[6.0]
  def change
    add_column :restaurants, :price, :string, default: '$', null: false
  end
end
