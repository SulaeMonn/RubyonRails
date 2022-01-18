require 'csv'
class PostsController < ApplicationController
  def posts
    @post = Post.new
  end

  # index post list
  def index
    # @posts = PostsService.postList
    @posts = Post.all.paginate(page: params[:page], per_page: 8).order("created_at DESC")
    respond_to do |format|
      format.html
      format.csv { send_data Post.all.to_csv, filename: "posts-#{Date.today}.csv" }
    end
  end

  def upload

  end

  def import
    Post.import(params[:file])
    redirect_to root_path, notice: "Data imported"
  end

  # search post list
  def search
    @query = params[:query]
    @posts = Post.where("posts.title LIKE ?",["%#{@query}%"]).paginate(page: params[:page], per_page: 8).order("created_at DESC")
    render :index
  end

  # Post Detail
  def show
    @post = PostsService.postDetail(params[:id])
  end

  # New Post form
  def new
    @post = Post.new
  end

  # Create Confirm post
  def createConfirm
    @post = Post.new(post_params)
  end

  # Create a new Post
  def create
    @post = Post.new(post_params)
    @post[:status] = 1
    @post[:create_user_id] = current_user.id
    @post[:updated_user_id] = current_user.id
    @post[:updated_at] = Time.now
    if @post.save
      redirect_to root_path
    else
      render :new
    end
  end

  # Delete post
  def destroy
    @post = PostsService.deletePost(params[:id])
    @post.destroy

    redirect_to posts_path
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # Edit Confirm post
  def editConfirm
    @post = Post.new(post_params)
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    @post = Post.find(params[:id])
    @post.status = params[:post][:status]

    if @post.update(post_params)
      redirect_to posts_path, :notice => "Your post has been updated!"
    else
      render "edit"
    end
  end

  private

  # post parameters
  def post_params
    params.require(:post).permit(:id, :title, :description, :status, :create_user_id, :updated_user_id, :updated_at)
  end
end
