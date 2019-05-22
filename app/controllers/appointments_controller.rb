class AppointmentsController < ApplicationController
  def index
    if !!Artist.find_by(id: current_user)
      @artist = Artist.find_by(id: current_user)
    else
      flash[:error] = "You must be a makeup artist to view"
      redirect_to client_path(current_user)
    end
  end

  def show
  end

  def new
    @artists = Artist.all
    @app = Appointment.new 
  end

  def create
    @app = Appointment.new(app_params)
    if @app.valid? && params[:date_time].to_date >= Date.today
      @app.pricing
      @app.client_id = current_user
      @app.save
      redirect_to appointment_path(@app)
    else
      flash[:error] = "Please try again: Date cannot be in the past. #{@app.errors.full_messages.to_sentence}"
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def app_params
    params.require(:appointment).permit(:date_time, :service, :artist_id, :client_id)
  end
end
