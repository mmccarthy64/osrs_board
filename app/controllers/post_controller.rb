class PostController < ApplicationController

    get '/posts' do
        redirect_if_not_logged_in
        @posts = Post.all
        if @posts == nil
            redirect to "/posts/new"
        else
            erb :'posts/index' #placeholder - switch to Activities Home Page
        end
    end

    get '/posts/new' do
        redirect_if_not_logged_in
        erb :'posts/new'
    end

    post '/posts' do
        redirect_if_not_logged_in
        if params[:content] == ""
            redirect to '/posts/new'
        else
            @post = current_user.posts.build(content: params[:content])
            if @post.save
                redirect to "/posts/#{@post.id}"
            else
                redirect to "/posts/new"
            end
        end
    end

    get '/posts/:id' do
        redirect_if_not_logged_in
        @post = Post.find_by_id(params[:id])
        erb :'posts/show'
    end

    get '/posts/:id/edit' do
        redirect_if_not_logged_in
        @post = Post.find_by_id(params[:id])
        if @post != "" && @post.user == current_user
            erb :'posts/edit'
        else
            redirect to '/posts'
        end
    end

    patch '/posts/:id' do
        redirect_if_not_logged_in
        if params[:content] == ""
            redirect to '/posts/#{params[:id]}/edit'
        else
            @post = Post.find_by_id(params[:id])
            if @post && @post.user == current_user
                if @post.update(content: params[:content])
                    redirect to '/posts/#{post.id}'
                else
                    redirect to '/posts/#{post.id}/edit'
                end
            else
                redirect to '/posts'
            end
        end
    end

    delete '/posts/:id/delete' do
        redirect_if_not_logged_in
        @post = Post.find_by_id(params[:id])
        if @post && @post.user == current_user
            @post.delete
        else
            redirect to '/posts/:id'
        end
    end
end