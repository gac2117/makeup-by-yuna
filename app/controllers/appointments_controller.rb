class AppointmentsController < ApplicationController
  def index
    if Artist.find_by(id: current_user)
      @artist = Artist.find_by(id: current_user)
    else
      flash[:error] = "You must be a makeup artist to view"
      redirect_to client_path(current_user)
    end
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
