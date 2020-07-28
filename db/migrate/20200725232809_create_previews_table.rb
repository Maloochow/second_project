class CreatePreviewsTable < ActiveRecord::Migration[4.2]
  def change
    create_table :previews do |t|
      t.integer :ticket_id
      t.integer :client_id
    end

    drop_table :clients_tickets

    remove_column :clients, :status
  end
end
