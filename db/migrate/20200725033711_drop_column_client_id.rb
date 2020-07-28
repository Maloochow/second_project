class DropColumnClientId < ActiveRecord::Migration[4.2]
  def change
    remove_column :tickets, :client_id
  end
end
