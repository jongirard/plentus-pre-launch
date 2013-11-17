class PostsController < ApplicationController 
  
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  
  def index
    @post = Post.all
    self.create
  end
  
  def create
    @post.update_from_feed
  end
  
  def show
     @post = Post.find(params[:id])
     redirect_to_good_slug(@post) and return if bad_slug?(@post)
  end
   
   private
   
   def record_not_found
     redirect_to :blog_index
     flash[:error] = "Post does not exist"
   end
end



