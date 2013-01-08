module Api
  module V2
    class PeopleController < ApplicationController
      respond_to :json
      
      def index
        respond_with Person.all
      end
      
      def show
        respond_with Person.find(params[:id])
      end
      
      def create
        respond_with Person.create(params[:show])
      end
      
      def update
        respond_with Person.update(params[:id], params[:show])
      end
      
      def destroy
        respond_with Person.destroy(params[:id])
      end
    end
  end
end
