class User < ApplicationRecord
  has_secure_password

  validates :name, :email, :password, presence: true
  validates :email, uniqueness: true, on: :create

  def self.popular(hash)
  	h = hash.max_by{|k,v| v}
  	return h[0]
  end
  
end
