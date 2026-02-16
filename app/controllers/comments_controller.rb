class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        # O Turbo busca o arquivo create.turbo_stream.erb automaticamente
        format.turbo_stream
        format.html { redirect_to @post, notice: "Comment transmitted." }
      else
        format.html { redirect_to @post, alert: "Signal corrupted: Comment failed." }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
