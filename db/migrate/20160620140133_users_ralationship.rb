class UsersRalationship < ActiveRecord::Migration
  def change
    create_table :users_ralationship, id: false do |t|
      t.belongs_to :user, index: true
    end
  end
end
