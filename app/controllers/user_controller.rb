class UserController < ApplicationController

    get '/signup' do
        erb :'users/signup'
    end
    
    post '/signup' do
        if params[:username] == "" || params[:password] == ""
            redirect to '/signup'
        else
            @user = User.create(:username => params[:username], :password => params[:password])
            # @user.save
            session[:user_id] = @user.id
            redirect to '/characters'
        end
    end
    
    get '/login' do
        if !logged_in?
          erb :'users/login'
        else
          redirect to '/characters'
        end
      end
    
      post '/login' do
        @user = User.find_by(:username => params[:username])
        if @user && @user.authenticate(params[:password])
          session[:user_id] = @user.id
          redirect to "/characters"
        else
          redirect to '/signup'
        end
      end
    
      get '/logout' do
        if logged_in?
          session.destroy
          redirect to '/'
        else
          redirect to '/'
        end
      end
end