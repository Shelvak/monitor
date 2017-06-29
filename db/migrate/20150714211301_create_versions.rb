class CreateVersions < ActiveRecord::Migration[4.2]
  def change
    create_table :versions do |t|
      t.string   :item_type, null: false
      t.integer  :item_id,   null: false
      t.string   :event,     null: false
      t.integer  :whodunnit
      t.json     :object
      t.json     :object_changes
      t.datetime :created_at
    end

    add_index :versions, :whodunnit
    add_index :versions, [:item_type, :item_id]
  end
end
