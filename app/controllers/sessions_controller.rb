class SessionsController < ApplicationController
  def new
     @user = User.new
   end

   def create
     if auth
       @user = User.find_or_create_by(uid: auth['uid']) do |u|
         u.name = auth['info']['name']
         u.email = auth['info']['email']
         u.extra = auth['info']['image']
         u.save
       end
       session[:user_id] = @user.id
       if Client.find_by(id: current_user)
         redirect_to client_path(@user)
       else
         redirect_to artist_path(@user)
       end

     else
       @user = User.find_by(email: params[:user][:email])
       if @user && @user.authenticate(params[:user][:password])
         session[:user_id] = @user.id
         if Client.find_by(id: current_user)
           redirect_to client_path(@user)
         else
           redirect_to artist_path(@user)
         end
       else
         flash[:error] = "Please try again. #{@user.errors.full_messages.to_sentence}"
         redirect_to signin_path
       end
     end
   end

   def destroy
     session[:user_id] = nil
     redirect_to root_url
   end

   private
   def auth
     request.env['omniauth.auth']
   end
 end
