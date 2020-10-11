require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "osrs_board_secret"
  end

  get "/" do
    erb :home
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      User.find(session[:user_id])
    end

    def authenticate_user
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect to '/posts'
      end
    end

    def redirect_if_not_logged_in
      if !logged_in?
        redirect to "/login"
      end
    end
  end

end
