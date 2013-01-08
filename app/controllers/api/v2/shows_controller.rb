module Api
  module V2
    class ShowsController < ApplicationController
      respond_to :json
      
      def index
        respond_with Show.all
      end
      
      def show
        respond_with Show.find(params[:id])
      end
      
      def create
        respond_with Show.create(params[:show])
      end
      
      def update
        respond_with Show.update(params[:id], params[:show])
      end
      
      def destroy
        respond_with Show.destroy(params[:id])
      end
    end
  end
end
