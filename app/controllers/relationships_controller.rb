class RelationshipsController < ApplicationController
    # def index 
    #     active_relationships = current_user.active_relationships
    #     passive_relationships = current_user.passive_relationships
    # end 

    def create 
        followed_user = User.find(params[:relationship][:followed_id])
        relationship = current_user.active_relationships.new(followed_id: followed_user.id)
        if relationship.save 
            render json: { relationship: relationship }, status: :created 
        else 
            render json: { error: 'failed to create user' }, status: :not_acceptable
        end 
    end 

    def destroy 
        relationship = Relationship.find(params[:id])
        if relationship.follower_user == current_user
            relationship.destroy 
            render json: { message: 'succesfully unfollowed'}, status: :accepted
        else
            render json: { error: 'failed to unfollow'}, status: :not_acceptable
        end 
    end 
end
