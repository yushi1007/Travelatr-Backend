class FavoritesController < ApplicationController
    before_action :find_destination, only: [:create]

    def index
        @favorites = Favorite.order(:id)
        render json: @favorites
    end 

    def create 
        @favorite = Favorite.create(user_id: params["user_id"], destination_id: params["destination_id"]) 
        logger.debug "New favorite: #{@favorite.attributes.inspect}"
        render json: @favorite
    end 
    
    def destroy
        @favorite = Favorite.find(params[:id])
        @favorite.destroy
        render json: @favorite
    end 
    
    private

    def find_destination
        @destination = Destination.find(params["destination_id"])
    end
end
