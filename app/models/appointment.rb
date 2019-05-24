class Appointment < ApplicationRecord
  belongs_to :client
  belongs_to :artist

  scope :by_date, -> {order(:date_time)}
end
