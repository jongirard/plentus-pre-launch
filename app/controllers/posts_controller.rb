class PostsController < ApplicationController 
  
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  
  
  def index
    @post = Post.all.order('published_at DESC').page(params[:page]).per(4)
    if params[:status] == "fetch"
      self.create
    end
  end
  
  def create
    @post.update_from_feed
  end

  
  def show
     @slug = Post.find_by guid: params[:guid]
     @post = Post.find_by_slug(params[:guid])
     if request.path != blog_path(@post)
       redirect_to blog_path(@slug), status: :moved_permanently
     end
  end
   
   private
   
   def record_not_found
     redirect_to :blog_index
   end
end



