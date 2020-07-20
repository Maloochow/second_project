class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :artwork
      t.date :starting_date
      t.date :ending_date
      t.datetime :create_time
      t.datetime :modify_time
      t.string :status

      t.timestamps null: false
    end
  end
end
