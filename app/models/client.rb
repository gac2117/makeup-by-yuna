class Client < User
  has_many :appointments
  has_many :artists, through: :appointments 
end
