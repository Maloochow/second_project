class CreatePreviewsTable < ActiveRecord::Migration
  def change
    create_table :previews do |t|
      t.integer :ticket_id
      t.integer :client_id
    end

    drop_table :clients_tickets

    remove_column :clients, :status
  end
end
