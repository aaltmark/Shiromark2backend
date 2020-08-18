class ReviewsController < ApplicationController
    skip_before_action :authorized, only: [:show, :index]

    def index 
        reviews = Review.all 
        render json: reviews
    end 

    def show 
        review = Review.find_by(id: params[:id])
        render json: {review: ReviewSerializer.new(review)}
    end 

    def create 
        @review = Review.create(review_params)
        # byebug
        if @review.valid? 
            render json: { review: ReviewSerializer.new(@review) }, status: :created 
        else 
            render json: { error: 'failed to create review' }, status: :not_acceptable
        end
    end

    def update 
        review = Review.find_by(id: params[:id])
        review.update(review_params) 
        if review.valid?
            render json: review 
        else 
            render json: { error: 'invalid review' }
        end 
    end 

    def destroy 
        review = Review.find_by(id: params[:id])
        review.destroy 
        render json: { message: 'review has been deleted'}
    end 
 
    private
    def review_params
        params.require(:review).permit(:rating, :user_id, :restaurant_id, :content, :title)
    end
end
