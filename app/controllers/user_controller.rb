class UserController < ApplicationController

    get '/user/new' do
        erb :'/user/new'
    end

    post '/user/signup' do 
        if @user = User.find_by(email: params[:email]) && !@user.username
            @user.update(params[:user])
            session[:user_id] = @user.id
            if @gallery = @user.gallery
            session[:gallery_id] = @gallery.id
            redirect "gallery/#{@gallery.id}"
            else
                erb :'/user/nogallery'
            end
        elsif @user = User.find_by(email: params[:email]) && @user.username
            redirect "/user/login"
        else
            @user = User.create(params[:user])
            session[:user_id] = @user.id
            erb :'/user/nogallery'
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
        erb :'/user/show'
        else
        redirect "/"
        end
    end


end