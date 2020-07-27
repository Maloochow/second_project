class UserController < ApplicationController

    get '/user/new' do
        erb :'/user/new'
    end

    post '/user/signup' do 
        @user = User.create(params[:user])
    if @user.id
        @user.email = params[:user][:email].downcase
        @user.save
        session[:user_id] = @user.id
        @invites = UserInvite.all.select {|invite| invite.new_user_email == @user.email}
        if @invites.count == 1
            @gallery = Gallery.find_by_id(@invites[0].user.gallery.id)
            @gallery.users << @user
            @invites[0].status = true
            session[:gallery_id] = @gallery.id
            redirect "/gallery/#{@gallery.id}"
        elsif @invites.count == 0
        erb :'/user/nogallery'
        else
            erb :'/user_invite/show'
        end
    else
        redirect "/user/login"
    end
    end

    post '/user/gallery/signup' do
        current_user
        if @gallery = Gallery.find_by_id(params[:gallery_id])
        @gallery.users << @user
        @invite = @gallery.tickets.where(new_user_email: @user.email)
        @invite.status = true
        @invite.save
        @invites = UserInvite.all.select {|invite| invite.new_user_email == @user.email && invite.status == false}
        @invites.each {|invite| invite.destroy}
        session[:gallery_id] = @gallery.id
        redirect "/gallery/#{@gallery.id}"
        else
        @invites = UserInvite.all.select {|invite| invite.new_user_email == @user.email}
        erb :'/user_invite/show'
        end
    end

    get '/user/login' do
        erb :'/user/login'
    end

    post "/user/login" do
        @user = User.find_by(email: params[:user][:email])
        if @user && @user.authenticate(params[:user][:password])
            session[:user_id] = @user.id
            session[:login]= true
          if @gallery = @user.gallery
            session[:gallery_id] = @gallery.id
          redirect "/gallery/#{@gallery.id}"
          else
            erb :'/user/nogallery'
          end
        else
          session[:login]=false
          erb :'/user/login'
        end
    end

    # post "/gallery/login" do
    #     if current_user
    #         @gallery = Gallery.find_by(name: params[:gallery][:name])
    #         if @gallery.users.include?(@user)
    #             session[:gallery_id] = @gallery.id
    #             redirect "/gallery/#{@gallery.id}"
    #         else
    #             erb :'/user/nogallery'   
    #         end            
    #     else
    #         erb :failure
    #     end
    # end

    post "/user/:id/gallery" do
        if current_user && !@user.gallery
            if Gallery.find_by(name: params[:gallery][:name])
                session[:gallery_name] = false
                erb :'/user/nogallery'
            else
                session[:gallery_name] = true
                @gallery = Gallery.create(params[:gallery])
                @gallery.admin_user_id = @user.id
                @gallery.users << @user
                @gallery.save
                session[:gallery_id] = @gallery.id
                redirect "/gallery/#{@gallery.id}"
            end
        else
            erb :failure
        end
    end
    
    get '/user/:id/edit' do 
        if logged_in? && @user == User.find_by_id(params[:id])
        erb :'/user/edit'
        else
        redirect "/"
        end
    end

    patch '/user/:id' do 
        current_user
        current_gallery
        @user.update(params[:user])
        redirect "/gallery/#{@gallery.id}/users"
    end
    
    get '/user/:id/delete' do
        if logged_in? && @user.id == @gallery.admin_user_id
            @user_2 = User.find_by_id(params[:id])
            @gallery.users.delete(@user_2) unless @user == @user_2
            @user_2.gallery_id = nil unless @user == @user_2
            redirect "/gallery/#{@gallery.id}/users"
        else
           erb :failure
        end
    end

    get '/gallery/:id/users' do 
        if logged_in?
            @emails = @gallery.users.map {|user| user.email}
            @invites = @gallery.user_invites.select do |invite| 
            !@emails.include?(invite.new_user_email)
            end
        erb :'/user/show'
        else
        redirect "/"
        end
    end


end