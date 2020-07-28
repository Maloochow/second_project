class RenameColumnInvitorId < ActiveRecord::Migration[4.2]
  def change
    rename_column :user_invites, :invitor_id, :user_id
  end
end
