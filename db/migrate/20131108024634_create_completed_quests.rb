class CreateCompletedQuests < ActiveRecord::Migration
  def change
    create_table :completed_quests, id: false do |t|
      t.integer :user_id
      t.integer :quest_id

      t.timestamps
    end
  end
end
