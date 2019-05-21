class ClientsController < ApplicationController
  def index
  end

  def show
    @client = User.find_by(id: current_user)
#    @appointments = Appointment.by_client(current_user)
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      session[:user_id] = @client.id
      redirect_to client_path(@client)
    else
      render :new
    end
  end

  def edit
    @client = User.find_by(id: current_user)
  end

  def update
    @client = User.find_by(id: current_user)
    if @client.update(client_params)
      redirect_to cilent_path(@client)
    else
      render :edit
    end
  end

  private
  def client_params
    params.require(:client).permit(:name, :email, :extra, :password)
  end
end
