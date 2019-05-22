class Appointment < ApplicationRecord
  belongs_to :client
  belongs_to :artist
#  scope :by_client, -> (id) { where (client_id: id) }

  def self.pricing
    if self.service == "Consultation"
      self.price = 35
    else
      self.price = 100
    end
  end
end
