class AddScoreToFrames < ActiveRecord::Migration
  def change
    add_column :frames, :score, :integer
  end
end
