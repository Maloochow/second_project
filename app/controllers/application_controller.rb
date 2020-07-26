require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "crazy1234%^&*"
  end

  get "/" do
    if logged_in?
      redirect "/gallery/#{session[:gallery_id]}"
    else
    @galleries = Gallery.all
    erb :welcome
    end
  end

  get "/failure" do
    erb :failure
  end

  get "/logout" do
    session.clear
    redirect "/"
  end


  private
  def logged_in?
      !!current_gallery && !!current_user && @gallery.users.include?(@user)
  end

  def current_gallery
      @gallery = Gallery.find_by_id(session[:gallery_id])
  end
  
  def current_user
      @user = User.find_by_id(session[:user_id])
  end

  def update_ticket_status
    if @ticket.starting_date > Date.today
        @ticket.status = "upcoming"
        @ticket.save
    elsif @ticket.ending_date < Date.today
        @ticket.status = "past"
        @ticket.save
    else
        @ticket.status = "current"
        @ticket.save
    end
  end

  def create_client
    @client = Client.create(params[:client])
    set_status
  end

  def set_status
    @status = ClientGalleryStatus.new(status: params[:status])
    @client.client_gallery_statuses << @status
    @gallery.client_gallery_statuses << @status
    @status.save
  end
end
