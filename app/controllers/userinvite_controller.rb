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
        @new_user = User.find_by(email: params["user"]["email"].downcase)
        if @new_user && !@new_user.gallery
            session[:user_invite] = true
            @user_invite = UserInvite.create(new_user_email: @new_user.email, status: true)
            @user.user_invites << @user_invite
            @gallery.users << @new_user
            redirect "/gallery/#{@gallery.id}/users"
        elsif @new_user && @new_user.gallery
            session[:user_invite] = false
            erb :'/user_invite/new'
        else
            @invite = UserInvite.create(new_user_email: params["user"]["email"].downcase, status: false)
            @user.user_invites << @invite
            redirect "/gallery/#{@gallery.id}/users"
        end
    end

    get "/invite/:id/delete" do
        @invite = UserInvite.find_by_id(params[:id])
        if logged_in? && @user.id == @invite.user_id || @user.id == @gallery.admin_user_id
        @user.user_invites.delete(@invite)
        @invite.destroy
        redirect "/gallery/#{@gallery.id}/users"
        else
            erb :failure
        end
    end



end