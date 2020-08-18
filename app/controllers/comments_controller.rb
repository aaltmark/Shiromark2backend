class CommentsController < ApplicationController
    def create 
        @comment = Comment.create(comment_params)
        if @comment.valid? 
            render json: { comment: CommentSerializer.new(@comment) }, status: :created 
        else 
            render json: { error: 'failed to create comment' }, status: :not_acceptable
        end
    end

    def destroy 
        comment = Comment.find_by(id: params[:id])
        comment.destroy 
        render json: { message: 'comment has been deleted'}
    end 

    private
    def comment_params
        params.require(:comment).permit(:content, :user_id, :review_id)
    end
end
