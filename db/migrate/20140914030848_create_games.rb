class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :frames_played, default:0
      t.boolean :is_completed, default:false
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
