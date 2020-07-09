class PostsController < ApplicationController
  def index 
    @posts = Post.all.order('created_at DESC')
  end

  def new
    @post = Post.new 
  end
  
  def create 
    @post = Post.new(post_params)
    
    if @post.save
      redirect_to @post
    else 
      render 'new' #如果沒有存取成功,會渲染一樣的new畫面，這樣頁面的資料不會被洗掉導致需要重新輸入
    end
  end

  def show
    @post = Post.find(params[:id])
  end
  

  def edit 
    @post = Post.find(params[:id])
  end


  def update
    @post = Post.find(params[:id])

    if @post.update(params[:post].permit(:title, :body))
      redirect_to @post
    else
      render 'edit'
    end
  end


  def destroy 
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "Post was deleted!"
    redirect_to posts_path
  end

  def set_post
    @post = Post.find(params[:post_id])
  end



  private 
  def post_params
    params.require(:post).permit(:title, :body)
  end
end
