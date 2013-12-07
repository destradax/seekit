class AddDetailsToQuests < ActiveRecord::Migration
  def change
    add_column :quests, :place_name, :string
    add_column :quests, :phone, :string
    add_column :quests, :fun_facts, :text
  end
end
