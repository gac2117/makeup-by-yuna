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
    @appointment = Appointment.find_by(id: params[:id])
  end

  def new
    if !!Client.find_by(id: current_user)
      @app = Appointment.new
      @client = Client.find_by(id: current_user)
    else
      flash[:error] = "You must be a client to view"
      redirect_to artist_path(current_user)
    end
  end

  def create
    @app = Appointment.new(app_params)
    if @app.valid?
      @app.save
      redirect_to client_appointment_path(current_user, @app)
    else
      flash[:error] = "Please try again. #{@app.errors.full_messages.to_sentence}"
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
    params.require(:appointment).permit(:date_time, :service, :comments, :artist_id, :client_id)
  end
end
