class ChangeColumnNewUserEmail < ActiveRecord::Migration[4.2]
  def change
    rename_column :user_invites, :new_user_id, :new_user_email
    change_column :user_invites, :new_user_email, :string
  end
end
