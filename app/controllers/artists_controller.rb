class ArtistsController < ApplicationController

  def index
  end

  def show
    if Client.find_by(id: current_user)
      @client = Client.find_by(id: current_user)
    end
    @artist = Artist.find_by(id: params[:id])
  end

  def new
    if logged_in?
      flash[:error] = "You are already signed in."
      if Client.find_by(id: current_user)
        redirect_to client_path(current_user)
      else
        redirect_to artist_path(current_user)
      end
    else
      @artist = Artist.new
    end
  end

  def create
    @artist = Artist.new(artist_params)
    if @artist.save
      session[:user_id] = @artist.id
      redirect_to artist_path(@artist)
    else
      flash[:error] = "Please try again."
      render :new
    end
  end

  def edit
    @artist = Artist.find_by(id: current_user)
  end

  def update
    @artist = Artist.find_by(id: current_user)
    if @artist.update(artist_params)
      redirect_to artist_path(@artist)
    else
      render :edit
    end
  end

  private
  def artist_params
    params.require(:artist).permit(:name, :email, :extra, :password)
  end
end
