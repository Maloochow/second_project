class ClientsTickets < ActiveRecord::Migration[4.2]
  def change
    create_table :clients_tickets, id: false do |t|
      t.belongs_to :clients
      t.belongs_to :tickets
    end
  end
end
