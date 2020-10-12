class CharacterController < ApplicationController

    get '/characters' do
        redirect_if_not_logged_in
        @user = current_user
        @characters = Character.all
        if @characters == []
            redirect "/characters/new"
        else
            erb :'characters/index'
        end
    end

    post '/characters' do
        redirect_if_not_logged_in
        @user = User.find(session[:user_id])
        if params[:name] == "" || params[:mode] == "" || params[:level] == ""
            redirect to '/characters/new'
        else
            @user = User.find_by(:id => session[:user_id])
            @character = Character.create(params)
            @character.user_id = @user.id
            @character.save
            redirect to "/characters"
        end
    end

    get '/characters/new' do
        redirect_if_not_logged_in
        @user = User.find_by(id: session[:user_id])
        erb :'characters/new'
    end

    get '/characters/:id' do
        redirect_if_not_logged_in
        @character = Character.find_by_id(params[:id])
        erb :'characters/show'
    end

    post '/characters/:id' do
        redirect_if_not_logged_in
        @character = Character.find(params[:id])
        @character.update(params)
        redirect to "/characters/#{@character.id}"
    end

    get '/characters/:id/edit' do
        redirect_if_not_logged_in
        @character = Character.find_by_id(params[:id])
        if @character && @character.user == current_user
            erb :'characters/edit'
        else
            redirect to "/error"
        end
    end

    delete '/characters/:id/delete' do
        redirect_if_not_logged_in
        @character = Character.find_by_id(params[:id])
        if @character && @character.user == current_user
            @character.delete
            redirect to "/characters"
        else
            redirect to "/error"
        end
    end
end