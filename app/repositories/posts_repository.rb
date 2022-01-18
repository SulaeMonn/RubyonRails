class PostsRepository
  # Get All Post List
  def self.getPostList
    @posts = Post.all.order("created_at DESC").paginate(page: params[:page], per_page: 7)
  end

  # Get Post Detail
  def self.getPostDetail(id)
    @post = Post.find(id)
  end

  # Create new Post
  def self.createPost(post)
    isSavePost = post.save
  end

  # delete post
  def self.deletePost(id)
    @post = Post.find(id)
  end
end