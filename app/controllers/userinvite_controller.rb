class UserInviteController < ApplicationController

    get "/gallery/:id/user/invite" do
        if logged_in?
            erb :'/user_invite/new'
        else
            erb :failure
        end
    end

    post "/gallery/:id/invite" do
        logged_in?
        @new_user = User.find_or_create_by(email: params["user"]["email"])
        if !@new_user.gallery
            if !@new_user.username 
                @new_user.password = params[:user][:password]
                @new_user.save
            end
            session[:user_invite] = true
            @user_invite = UserInvite.new
            @user_invite.invitor_id = @user.id
            @user_invite.new_user_id = @new_user.id
            @user_invite.save
            @gallery.users << @new_user
            redirect "/gallery/#{@gallery.id}/users"
        else
            session[:user_invite] = false
            erb :'/user_invite/new'
        end
    end

    get "/invite/:id/delete" do
        @user_invite = UserInvite.find_by_id(params[:id])
        if logged_in? && @user.id == @user_invite.invitor_id || @user.id == @gallery.admin_user_id
        @new_user = User.find_by_id(@user_invite.new_user_id)
        @gallery.users.delete(@new_user)
        @new_user.gallery_id = nil
        else
            erb :failure
        end
    end



end