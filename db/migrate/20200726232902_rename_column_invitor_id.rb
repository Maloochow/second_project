class RenameColumnInvitorId < ActiveRecord::Migration
  def change
    rename_column :user_invites, :invitor_id, :user_id
  end
end
