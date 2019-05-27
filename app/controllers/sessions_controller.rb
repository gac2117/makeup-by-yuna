class SessionsController < ApplicationController
  def new
     @user = User.new
   end

   def create
    if auth
      # logs in using Facebook
      @user = Client.find_or_create_by_omniauth(auth)
        if @user
          session[:user_id] = @user.id
          if Client.find_by(id: current_user)
            redirect_to client_path(@user)
          else
            redirect_to artist_path(@user)
          end
        else
          flash[:error] = "Please try again."
          render :new
        end
    else
      #logs in using email
      @user = User.find_by(email: params[:user][:email])
        if @user && @user.authenticate(params[:user][:password])
          session[:user_id] = @user.id
            if Client.find_by(id: current_user)
              redirect_to client_path(@user)
            else
              redirect_to artist_path(@user)
            end
        else
          flash[:error] = "Please try again."
          redirect_to signin_path
        end
     end
   end

   def destroy
     session[:user_id] = nil
     redirect_to root_path
   end

  
 end
