class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :owned_post, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:success] = "Votre post a été créé!"
      redirect_to posts_path
    else
      flash[:alert] = "Votre post ne peut être créé 8"
      render :new
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

  def owned_post
    unless current_user == @post.user
      flash[:alert] = "Ce poste ne vous appartient pas !"
      redirect_to root_path
    end
  end

end
