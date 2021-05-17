class DestinationsController < ApplicationController
    def index
        @destinations = Destination.order(:id)
        render json: @destinations
    end

    def show 
        @destination = Destination.find(params[:id])
        render json: @destination
    end
end
