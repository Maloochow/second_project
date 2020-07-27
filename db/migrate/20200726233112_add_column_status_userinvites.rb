class AddColumnStatusUserinvites < ActiveRecord::Migration
  def change
    add_column :user_invites, :status, :boolean
  end
end
