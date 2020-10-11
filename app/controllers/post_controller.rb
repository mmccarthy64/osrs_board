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
            current_user.posts = Post.create(params)
            redirect to "/posts/myposts"
        end
    end

    get '/posts/myposts' do
        @posts = current_user.posts
        erb :'users/myposts'
    end

    get '/posts/:id' do
        redirect_if_not_logged_in
        @post = Post.find_by_id(params[:id])
        erb :'posts/show'
    end

    post '/posts/:id' do
        redirect_if_not_logged_in
        @post = Post.find(params[:id])
        @post.update(params)
        redirect to "/posts/#{@post.id}"
    end

    get '/posts/:id/edit' do
        redirect_if_not_logged_in
        @post = Post.find_by_id(params[:id])
        erb :'posts/edit'
    end

    # patch '/posts/:id' do
    #     redirect_if_not_logged_in
    #     if params[:content] == ""
    #         redirect to '/posts'
    #     else
    #         @post = Post.find_by_id(params[:id])
    #         if @post && @post.user == current_user
    #             if @post.update(content: params[:content])
    #                 redirect to '/posts/#{post.id}'
    #             else
    #                 redirect to '/posts/#{post.id}/edit'
    #             end
    #         else
    #             redirect to '/posts'
    #         end
    #     end
    # end

    delete '/posts/:id/delete' do
        redirect_if_not_logged_in
        @post = Post.find_by_id(params[:id])
        if @post && @post.user == current_user
            @post.delete
        else
            redirect to '/error'
        end
    end
end