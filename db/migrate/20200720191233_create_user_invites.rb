class CreateUserInvites < ActiveRecord::Migration[4.2]
  def change
    create_table :user_invites do |t|
      t.integer :invitor_id
      t.integer :new_user_id

      t.timestamps null: false
    end
  end
end
