class SessionsController < ApplicationController
  def new
     @user = User.new
   end

   def create
     if auth
       if @user = User.find_by(email: auth['email']) 
        raise "Existing user".inspect
         session[:user_id] = @user.id
         if Client.find_by(id: current_user)
           redirect_to client_path(@user)
         else
           redirect_to artist_path(@user)
         end
       else
         @user = Client.new(email: auth['info']['email']) do |u|
           u.name = auth['info']['name']
           u.extra = auth['info']['image']
         end
         if @user.save
          session[:user_id] = @user.id
          redirect_to client_path(@user)
        else
          raise @user.errors.full_messages.inspect
          flash[:error] = "Please try again."
          render :new
        end
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
     redirect_to root_path
   end

  
 end
