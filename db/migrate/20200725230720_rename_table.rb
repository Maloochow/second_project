class RenameTable < ActiveRecord::Migration
  def change
    rename_table :client_gallery_status, :client_gallery_statuses
  end
end
