class LikesController < ApplicationController
    before_action :find_destination, only: [:create]

    def index 
        @likes = Like.order(:id)
        render json: @likes
    end

    def create 
        @like = Like.create(user_id: params["user_id"], destination_id: params["destination_id"])
        render json: @destination
    end 

    private 

    def find_destination
        @destination = Destination.find(params["destination_id"])
    end
end
