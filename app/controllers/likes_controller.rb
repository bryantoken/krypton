class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    @like = @post.likes.build(user: current_user)
    
    if @like.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace(
              "like_button_post_#{@post.id}",
              partial: "posts/like_button",
              locals: { post: @post }
            ),
            turbo_stream.replace(
              "likes_count_post_#{@post.id}",
              partial: "posts/likes_count_display",
              locals: { post: @post }
            )
          ]
        end
        format.html { redirect_to @post, notice: "Post liked!" }
      end
    else
      respond_to do |format|
        format.html { redirect_to @post, alert: "Could not like post." }
      end
    end
  end

  def destroy
    @like = @post.likes.find(params[:id])
    @like.destroy
    
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace(
            "like_button_post_#{@post.id}",
            partial: "posts/like_button",
            locals: { post: @post }
          ),
          turbo_stream.replace(
            "likes_count_post_#{@post.id}",
            partial: "posts/likes_count_display",
            locals: { post: @post }
          )
        ]
      end
      format.html { redirect_to @post, notice: "Post unliked!" }
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
