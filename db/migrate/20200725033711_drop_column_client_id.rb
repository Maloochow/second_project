class DropColumnClientId < ActiveRecord::Migration
  def change
    remove_column :tickets, :client_id
  end
end
