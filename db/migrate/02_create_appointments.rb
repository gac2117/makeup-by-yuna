class CreateAppointments < ActiveRecord::Migration[4.2]
  def change
    create_table :appointments do |t|
      t.belongs_to :artist
      t.belongs_to :client
      t.datetime :date_time
      t.integer :price
      t.string :service
      t.timestamps null: false
    end
  end
end
