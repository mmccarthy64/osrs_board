class UserController < ApplicationController

    get '/signup' do
        erb :'users/signup'
    end
    
    post '/signup' do
        if params[:username] == "" || params[:password] == ""
            redirect to '/signup'
        else
            @user = User.new(:username => params[:username], :password => params[:password])
            @user.save
            session[:user_id] = @user.id
            redirect to '/posts'
        end
    end
    
    get '/login' do
        if !logged_in?
            erb :'users/login'
        else
            redirect to '/posts'
        end
    end

    post '/login' do
        @user = User.find_by(:username => params[:username])
        authenticate_user
    end

    get '/logout' do
        if logged_in?
            session.destroy
            redirect to '/login'
        else
            redirect to '/'
        end
    end
end