class Artist < User
  has_many :appointments
  has_many :clients, through: :appointments

  attr_accessor :secret

  scope :app_count, -> { joins(:appointments).group('artist_id').count }

end
