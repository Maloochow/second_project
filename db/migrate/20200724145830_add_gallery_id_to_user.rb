class AddGalleryIdToUser < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :gallery_id, :integer
  end
end
