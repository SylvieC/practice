class AddTurn3ToFrames < ActiveRecord::Migration
  def change
    add_column :frames, :turn3, :integer
  end
end
