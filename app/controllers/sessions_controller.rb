class SessionsController < ApplicationController
  def new
     @user = User.new
   end

   def create
     @user = User.find_by(email: params[:user][:email])
     if @user && @user.authenticate(params[:user][:password])
       session[:user_id] = @user.id
       if Client.find_by(id: current_user)
         redirect_to client_path(@user)
       else
         redirect_to artist_path(@user)
       end
     else
       redirect_to signin_path
     end
   end

   def destroy
     session[:user_id] = nil
     redirect_to root_url
   end
end
