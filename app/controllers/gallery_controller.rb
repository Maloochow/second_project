class GalleryController < ApplicationController

    get '/gallery/new' do
        erb :'/gallery/new'
    end

    post '/gallery' do 
        @gallery = Gallery.new(params[:gallery])
        @user = User.create(params[:user])
        @user.email.downcase
        @user.save
        if @user.save
            @gallery.users << @user
            @gallery.admin_user_id = @user.id
            @gallery.save
            session[:user_id] = @user.id
            session[:gallery_id] = @gallery.id
            redirect "gallery/#{@gallery.id}"
        else
            redirect "/gallery/new"
        end
    end
    
    get '/gallery/:id/edit' do 
        if logged_in?
        erb :'/gallery/edit'
        else
        redirect "/"
        end
    end

    get '/gallery/:id/delete' do 
        if logged_in? && @user.id == @gallery.admin_user_id
        @gallery.delete
        @user.delete
        session.clear
        redirect "/"        
        else
            erb :failure

        end
    end

    get '/gallery/:id' do 
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
            @show_tickets = @gallery.tickets.select {|ticket| ticket.status == "upcoming" || ticket.status == "current"}
            erb :'/gallery/show'
        else
        redirect "/"
        end
    end

    patch '/gallery/:id' do 
        current_gallery
        @gallery.name = params[:name]
        redirect "/gallery/#{@gallery.id}"
    end

end