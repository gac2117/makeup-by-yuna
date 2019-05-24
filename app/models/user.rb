class User < ApplicationRecord
  has_secure_password

  validates :name, :email, :password, presence: true
  validates :email, uniqueness: true, on: :create

  def self.find_or_create_by_omniauth(auth)
	if @user = User.find_by(email: auth['info']['email']) 
		return @user 	    
    else
	    @user = Client.new(email: auth['info']['email']) do |u|
	       u.name = auth['info']['name']
	       u.extra = auth['info']['image']
	       u.password = SecureRandom.hex
	    end
	    raise "new user".inspect
	    if @user.save
		    return @user
		end
    end
  end
end
