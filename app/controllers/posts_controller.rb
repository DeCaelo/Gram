class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
   if @post = Post.create(post_params)
      flash[:success] = "Post créé avec succès !"
      redirect_to posts_path
    else
      flash.now[:alert] = "Impossible de créer votre Post !"
      render 'new'
    end
  end

  def show

  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:success] = "Post édité !"
      redirect_to post_path(@post)
    else
      flash.now[:alert] = "Impossible d'éditer le Post !"
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:image, :caption)
  end

  def find_post
    @post = Post.find(params[:id])
  end

end
