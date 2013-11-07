class CreateQuests < ActiveRecord::Migration
  def change
    create_table :quests do |t|
      t.decimal :latitude
      t.decimal :longitude
      t.string :name
      t.string :address
      t.string :hint
      t.text :brief
      t.integer :difficulty

      t.timestamps
    end
  end
end
