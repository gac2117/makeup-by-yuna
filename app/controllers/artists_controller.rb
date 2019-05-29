class ArtistsController < ApplicationController

  def index
  end

  def show
    @artist = Artist.find_by(id: params[:id])
    @user = User.find_by(id: current_user)
    if @user == @artist
      @current_artist = @user
    elsif Artist.find_by(id: @user)
      @other_artist = @user
    else
      @client = Client.find_by(id: @user)
    end
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
    if @artist.save && params[:artist][:secret] == "BTS"
      session[:user_id] = @artist.id
      redirect_to artist_path(@artist)
    else
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

  def popular
    hash = Artist.app_count
    popular_id = Artist.popular(hash)
    @artist = Artist.find_by(id: popular_id)
  end


  private
  def artist_params
    params.require(:artist).permit(:name, :email, :extra, :password, :secret)
  end
end
