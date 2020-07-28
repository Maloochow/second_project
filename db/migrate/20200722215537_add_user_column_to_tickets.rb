class AddUserColumnToTickets < ActiveRecord::Migration[4.2]
  def change
    add_column :tickets, :user_id, :integer
    add_column :tickets, :client_id, :integer
  end
end
