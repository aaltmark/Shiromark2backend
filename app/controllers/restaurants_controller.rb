class RestaurantsController < ApplicationController
    skip_before_action :authorized, only: [:index, :show]

    def index 
        restaurants = Restaurant.all 
        render json: restaurants, include: [:reviews] 
    end 

    def show 
        restaurant = Restaurant.find_by(id: params[:id])
        render json: restaurant, include: [:reviews]
    end 


end
