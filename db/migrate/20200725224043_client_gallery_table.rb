class ClientGalleryTable < ActiveRecord::Migration[4.2]
  def change
    create_table :client_gallery_status do |t|
      t.integer :client_id
      t.integer :gallery_id
      t.boolean :status
    end
  end
end
