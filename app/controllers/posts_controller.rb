class PostsController < ApplicationController
  before_action :ensure_current_user, only: [:edit, :update, :destroy]
  
  def index
    @posts=Post.all.order(created_at: :desc)
  end
  def create
    @post = current_user.posts.new(content: params[:content],user_id: @current_user.id)
    if @post.save
      flash[:notice]="投稿しました"
      redirect_to posts_path
      
    else
      render new_post_path
    end
  end
  def show
    @post=Post.find_by(id: params[:id])
    @user=User.find_by(id: @post.user_id)
  
  end
  def new
    @post=Post.new
  end
  def edit
    @post= Post.find_by(id: params[:id])
    
  end
  def update
    @post= Post.find_by(id: params[:id])
    @post.content=params[:content]
    if @post.save
      flash[:notice] ="投稿を編集しました"
      redirect_to posts_path
    else
      flash[:notice] ="投稿を編集できませんでした"
      render edit_post_path
      
    end
  end
  def destroy
    @post= Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice]="削除しました"
    redirect_to posts_path
  end
  def ensure_current_user
    
    @post= current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to posts_path
    end
  end  
end