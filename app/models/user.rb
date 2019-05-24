class User < ApplicationRecord
  has_secure_password

  validates :name, :email, :password, presence: true
  validates :email, uniqueness: true, on: :create

	def self.find_or_create_by_omniauth(auth)
	  	self.where(email: auth['info']['email']).first_or_create do |u|
	  		u.name = auth['info']['name']
		    u.extra = auth['info']['image']
		    u.password = SecureRandom.hex
	    end
	end

	# if @user = User.find_by(email: auth['info']['email']) 
	# 	return @user 	    
 #    else
	#     @user = Client.new(email: auth['info']['email']) do |u|
	       
	#     raise "new user".inspect
	#     if @user.save
	# 	    return @user
	# 	end
 #    end
 #  end
end
