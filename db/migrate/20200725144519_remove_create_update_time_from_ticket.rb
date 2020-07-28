class RemoveCreateUpdateTimeFromTicket < ActiveRecord::Migration[4.2]
  def change
    remove_column :tickets, :create_time
    remove_column :tickets, :modify_time
  end
end
