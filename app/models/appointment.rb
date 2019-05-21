class Appointment < ApplicationRecord
  belongs_to :client
  belongs_to :artist
#  scope :by_client, -> { where (client_id: 'current_user') }
end
