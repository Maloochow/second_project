class ClientController < ApplicationController
get '/gallery/:id/client/new' do
    if logged_in?
        erb :'/client/new'
    else
      erb :failure
    end
end

post '/gallery/:id/client' do 
    if logged_in?
      if @client = Client.find_by(app_id: params["client"]["app_id"])
        set_status
      else
      create_client
      end
      redirect "/gallery/#{@gallery.id}/clients"
    else
      erb :failure
    end
end

get '/client/:id/edit' do 
    @client = Client.find_by_id(params[:id])
    if logged_in? && @gallery.clients.include?(@client)
      @cgstatus = ClientGalleryStatus.find_by(gallery_id: @gallery.id, client_id: @client.id).status
       erb :'/client/edit'
    else
       erb :failure
    end
end

patch '/client/:id' do
  @client = Client.find_by_id(params[:id])
  if logged_in? && @gallery.clients.include?(@client)
    @status = ClientGalleryStatus.find_by(gallery_id: @gallery.id, client_id: @client.id)
        @status.status = params[:status]
        @status.save
        redirect "gallery/#{@gallery.id}/clients"
  else
    erb :failure
  end
end

get '/client/:id/delete' do
    @client = Client.find_by_id(params[:id])
    if logged_in? && @user.id == @gallery.admin_user_id
      @status = ClientGalleryStatus.find_by(gallery_id: @gallery.id, client_id: @client.id)
      @gallery.client_gallery_statuses.delete(@status)
      @client.client_gallery_statuses.delete(@status)
      @status.delete
      redirect "gallery/#{@gallery.id}/clients"
    else
      erb :failure
    end
end

get '/gallery/:id/clients' do 
    if logged_in?
      @clients = @gallery.clients
      erb :'/client/show_all'
    else
      erb :failure
    end
end

get '/client/:id' do
  @client = Client.find_by_id(params[:id])
  if logged_in? && @gallery.clients.include?(@client)
    @tickets = @gallery.tickets.select {|t| t.clients.include?(@client)}
    @tickets.each do |t|
      if t.starting_date > Date.today
        t.status = "upcoming"
        t.save
      elsif t.ending_date < Date.today
          t.status = "past"
          t.save
      else
          t.status = "current"
          t.save
      end
    end
    @cgstatus = ClientGalleryStatus.find_by(gallery_id: @gallery.id, client_id: @client.id)
    erb :'/client/show'
  else
    erb :failure
  end
end

end