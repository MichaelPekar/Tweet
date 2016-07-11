class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.integer :author_id
      t.string :action
      t.integer :trackable_id
      t.string :trackable_type
      t.boolean :read, default: false
      t.timestamps
    end

    add_index :notifications, [:trackable_id, :trackable_type]
    add_index :notifications, :user_id
    add_index :notifications, :author_id
    add_index :notifications, :read
  end
end
