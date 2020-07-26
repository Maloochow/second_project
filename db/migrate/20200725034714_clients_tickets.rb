class ClientsTickets < ActiveRecord::Migration
  def change
    create_table :clients_tickets, id: false do |t|
      t.belongs_to :clients
      t.belongs_to :tickets
    end
  end
end
