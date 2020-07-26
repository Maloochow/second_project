class ClientGalleryTable < ActiveRecord::Migration
  def change
    create_table :client_gallery_status do |t|
      t.integer :client_id
      t.integer :gallery_id
      t.boolean :status
    end
  end
end
