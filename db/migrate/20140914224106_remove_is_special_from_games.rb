class RemoveIsSpecialFromGames < ActiveRecord::Migration
  def change
    remove_column :games, :is_special, :boolean
  end
end
