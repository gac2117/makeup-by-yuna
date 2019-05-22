class FacebookController < ApplicationController
  def new
    @user = User.new
  end

  def create
   @user = User.find_or_create_by(uid: auth['uid']) do |u|
     u.name = auth['info']['name']
     u.email = auth['info']['email']
     u.extra = auth['info']['image']
   end

   session[:user_id] = @user.id
   if Client.find_by(id: current_user)
     redirect_to client_path(@user)
   else
     redirect_to artist_path(@user)
   end
 end

 private

 def auth
   request.env['omniauth.auth']
 end
end
