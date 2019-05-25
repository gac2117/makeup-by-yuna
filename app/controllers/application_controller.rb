require 'pry'
require 'rack-flash'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  use Rack::Flash
  helper_method :current_user, :logged_in?

  before_action :current_user
  before_action :require_login, except: [:new, :create, :home]

  def current_user
    session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  private
  def require_login
    unless logged_in?
      flash[:error] = "Please sign in first."
      redirect_to root_url
    end
  end
   
   def auth
     request.env['omniauth.auth']
   end
end
