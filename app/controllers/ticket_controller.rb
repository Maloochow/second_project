class TicketController < ApplicationController
    
    get '/gallery/:id/ticket/new' do
        if logged_in?
            erb :'/ticket/new'
        else
            redirect "/"
        end
    end
    
    post '/gallery/:id/ticket' do 
        if logged_in?
            @ticket = Ticket.create(params[:ticket])
            @user.tickets << @ticket
            if params.keys.include?("previews")
                params["previews"].each do |id|
                    preview = Preview.new
                    client = Client.find_by_id(id)
                    client.previews << preview
                    @ticket.previews << preview
                end
            end
            if !params["client"]["app_id"].empty?
                @client = Client.find_or_create_by(params["client"])
                if !preview = Preview.find_by(client_id: @client.id, ticket_id: @ticket.id)
                preview = Preview.new
                @client.previews << preview
                @ticket.previews << preview
                @status = ClientGalleryStatus.new(status: true)
                @client.client_gallery_statuses << @status
                @gallery.client_gallery_statuses << @status
                end
            end
            update_ticket_status
            redirect "/gallery/#{@gallery.id}/tickets"
        else
            redirect '/'
        end
    end
    
    get '/ticket/:id/edit' do 
        @ticket = Ticket.find_by_id(params[:id])
        if logged_in?
            if @user == @ticket.user || @user.id == @gallery.admin_user_id 
                erb :'/ticket/edit'
            else
                redirect "/gallery/#{@galery.id}"
            end
        else
            redirect "/"
        end
    end
    
    patch '/ticket/:id' do
        if logged_in? 
            @ticket = Ticket.find_by_id(params[:id])
            @ticket.update(params["ticket"])
            @previews = Preview.where(ticket_id: @ticket.id).map {|p| p.client_id}
            if !params.keys.include?("previews")
                params[:previews] = []
            end
            common_client = params[:previews] & @previews
            new_client = params[:previews] - common_client
            remove_client = @previews - common_client
            if remove_client != []
                remove_client.each do |id|
                Preview.find_by(ticket_id: @ticket.id, client_id: id).delete
                end
            end
            if new_client != []
                new_client.each do |id|
                   preview = Preview.new
                   client = Client.find_by_id(id)
                   client.previews << preview
                   @ticket.previews << preview
                end
            end
            if !params["client"]["app_id"].empty?
                create_client
                preview = Preview.new
                @client.previews << preview
                @ticket.previews << preview
            end
            update_ticket_status
            redirect "gallery/#{@gallery.id}/tickets"
        else
            redirect "/"
        end
    end
    
    get '/ticket/:id/delete' do
        @ticket = Ticket.find_by_id(params[:id])
        if logged_in?
            if @user.id == @gallery.admin_user_id || @user == @ticket.user
                @ticket.delete
                redirect "gallery/#{@gallery.id}/tickets"
            else
                redirect "/gallery/#{@gallery.id}"
            end
        else
            erb :failure
        end
    end
    
    get '/gallery/:id/tickets' do 
        if logged_in?
            @gallery.tickets.each do |ticket|
                if ticket.starting_date > Date.today
                    ticket.status = "upcoming"
                    ticket.save
                elsif ticket.ending_date < Date.today
                    ticket.status = "past"
                    ticket.save
                else
                    ticket.status = "current"
                    ticket.save
                end
            end
            @tickets = @gallery.tickets
            erb :'/ticket/show_all'
        else
            redirect "/"
        end
    end
        
    get '/ticket/:id' do
        if logged_in?
        @ticket = Ticket.find_by_id(params[:id])
        update_ticket_status
        erb :'/ticket/show'
        else
        redirect "/"
        end
    end
    
end