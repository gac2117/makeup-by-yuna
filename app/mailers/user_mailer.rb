class UserMailer < ApplicationMailer
	def welcome_email(user)
		@user = user
	    mail(to: @user.email, subject: 'Welcome to Makeup by Yuna')
	end

	def forgot_password(user)
	  @user = user
	  @greeting = "Hi"
	  
	  mail to: user.email, :subject => 'Reset password instructions'
	end

end
