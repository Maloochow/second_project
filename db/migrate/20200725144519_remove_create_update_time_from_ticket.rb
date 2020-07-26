class RemoveCreateUpdateTimeFromTicket < ActiveRecord::Migration
  def change
    remove_column :tickets, :create_time
    remove_column :tickets, :modify_time
  end
end
