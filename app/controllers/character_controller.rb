class CharacterController < ApplicationController

    get '/characters' do
        redirect_if_not_logged_in
        @characters = Character.all
        if @characters == []
            redirect "/characters/new"
        else
            erb :'characters/index'
        end
    end

    post '/characters' do
        redirect_if_not_logged_in
        if params[:name] == "" || params[:mode] == "" || params[:level] == ""
            redirect to '/characters/new'
        else
            @character = Character.create(params)
            redirect to "/characters"
        end
    end

    get '/characters/new' do
        redirect_if_not_logged_in
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
        erb :'characters/edit'
    end

    delete '/characters/:id/delete' do
        redirect_if_not_logged_in
        @character = Character.find_by_id(params[:id])
        if @character && @character.user == current_user
            @character.delete
        else
            redirect to '/error'
        end
    end
end