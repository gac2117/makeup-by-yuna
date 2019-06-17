class AppointmentsController < ApplicationController
  def index
    if !!Artist.find_by(id: current_user)
      @artist = Artist.find_by(id: current_user)
      @apps = @artist.appointments.by_date
      respond_to do |format|
        format.html { render :index }
        format.json { render json: @apps, status: 200}
      end
    else
      flash[:error] = "You must be a makeup artist to view"
      redirect_to client_path(current_user)
    end
  end

  def show
    @app = Appointment.find_by(id: params[:id])
    if !!Client.find_by(id: current_user)
      @client = Client.find_by(id: current_user)
    else
      @artist = Artist.find_by(id:current_user)
    end
  end

  def new
    if !!Client.find_by(id: current_user)
      @client = Client.find_by(id: current_user)
      @app = Appointment.new
    else
      flash[:error] = "You must be a client to view"
      redirect_to artist_path(current_user)
    end
  end

  def create
    @app = Appointment.new(app_params)
    if @app.save
      respond_to do |format|
        format.html { redirect_to client_appointment_path(current_user, @app) }
        format.json { render json: @app, status: 201 }
    else
      @client = Client.find_by(id: current_user)
      render :new
    end
  end

  def edit
    if !!Client.find_by(id: current_user)
      @app = Appointment.find_by(id: params[:id])
      @client = Client.find_by(id: current_user)
    else
      flash[:error] = "You must be a client to edit"
      redirect_to artist_path(current_user)
    end
  end

  def update
    @app = Appointment.find_by(id: params[:id])
    if @app.update(app_params)
      respond_to do |format|
        format.html { redirect_to client_appointment_path(current_user, @app) }
        format.json { render json: @app, status: 202 }
    else
      @client = Client.find_by(id: current_user)
      render :edit
    end
  end

  def destroy
    @app = Appointment.find_by(id: params[:id])
    if @app.client.id == current_user
      @app.delete
      flash[:notice] = "Your appointment has been deleted."
      redirect_to client_path(current_user)
    else
      flash[:error] = "You cannot delete other people's records."
      redirect_to client_appointment_path(current_user, @app)
    end
  end

  private
  def app_params
    params.require(:appointment).permit(:date_time, :service, :comments, :artist_id, :client_id)
  end
end
