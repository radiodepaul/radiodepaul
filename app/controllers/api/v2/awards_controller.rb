class Api::V2::AwardsController < Api::V2::ApiController
  respond_to :json

  def index
    render json: Award.all
  end

  def show
    render json: Award.find(params[:id])
  end

  def create
    render json: Award.create(params[:show])
  end

  def update
    render json: Award.update(params[:id], params[:show])
  end

  def destroy
    render json: Award.destroy(params[:id])
  end
end
