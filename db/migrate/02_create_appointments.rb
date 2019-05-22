class CreateAppointments < ActiveRecord::Migration[4.2]
  def change
    create_table :appointments do |t|
      t.belongs_to :artist
      t.belongs_to :client
      t.datetime :date_time
      t.string :service
      t.text :comments
      t.timestamps null: false
    end
  end
end
