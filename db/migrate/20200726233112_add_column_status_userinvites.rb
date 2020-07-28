class AddColumnStatusUserinvites < ActiveRecord::Migration[4.2]
  def change
    add_column :user_invites, :status, :boolean
  end
end
