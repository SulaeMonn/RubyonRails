class PostsService
    # post list
    def self.postList
      @posts = PostsRepository.getPostList
    end

    # post detail
    def self.postDetail(id)
      @post = PostsRepository.getPostDetail(id)
    end

    # Create new Post
    # params post_params
    # return isSavePost
    def self.createPost(post_params)
      post = Post.new(post_params)
      post.status = 1 # default when create
      post.create_user_id = current_user.id #It will change when user is created
      post.updated_user_id = current_user.id  #It will change when user is created
      post.updated_at = Time.now
      isSavePost = PostsRepository.createPost(post)
    end

    # Delete post
    def self.deletePost(id)
      @post = PostsRepository.deletePost(id)
    end
end