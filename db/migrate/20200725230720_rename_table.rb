class RenameTable < ActiveRecord::Migration[4.2]
  def change
    rename_table :client_gallery_status, :client_gallery_statuses
  end
end
