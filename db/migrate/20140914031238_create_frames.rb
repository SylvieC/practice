class CreateFrames < ActiveRecord::Migration
  def change
    create_table :frames do |t|
      t.integer :turn1
      t.integer :turn2
      t.belongs_to :game, index: true

      t.timestamps
    end
  end
end
