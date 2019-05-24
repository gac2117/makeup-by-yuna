class Appointment < ApplicationRecord
  belongs_to :client
  belongs_to :artist

  validates :date_time, :service, :artist_id, presence: true

  scope :by_date, -> {order(:date_time)}
end
