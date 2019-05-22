class Artist < User
  has_many :appointments
  has_many :clients, through: :appointments

  attr_accessor :secret
end
