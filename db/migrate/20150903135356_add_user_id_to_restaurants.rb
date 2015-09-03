class AddUserIdToRestaurants < ActiveRecord::Migration
  def change
    add_reference :restaurants, :user, index: true, foreign_key: true
  end
end
