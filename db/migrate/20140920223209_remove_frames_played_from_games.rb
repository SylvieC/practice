class RemoveFramesPlayedFromGames < ActiveRecord::Migration
  def change
    remove_column :games, :frames_played, :integer
  end
end
