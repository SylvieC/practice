class AddIsSpecialToGames < ActiveRecord::Migration
  def change
    add_column :games, :is_special, :boolean, default: false
  end
end
