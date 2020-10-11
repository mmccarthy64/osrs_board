require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "osrs_board_secret"
  end

  get "/" do
    if logged_in?
      redirect to "/characters"
    else
      erb :home
    end
  end

  get '/error' do
    erb :error
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def redirect_if_not_logged_in
      if !logged_in?
        redirect to "/login"
      end
    end
  end

end
