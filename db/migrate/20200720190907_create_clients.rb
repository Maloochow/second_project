class CreateClients < ActiveRecord::Migration[4.2]
  def change
    create_table :clients do |t|
      t.string :app_id
      t.boolean :status

      t.timestamps null: false
    end
  end
end
