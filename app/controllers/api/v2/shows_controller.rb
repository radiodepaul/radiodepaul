class Api::V2::ShowsController < Api::V2::ApiController
  respond_to :json

  def index
    render json: Show.all
  end

  def show
    render json: Show.find(params[:id])
  end

  def create
    render json: Show.create(params[:show])
  end

  def update
    render json: Show.update(params[:id], params[:show])
  end

  def destroy
    render json: Show.destroy(params[:id])
  end

  def random
    render json: Show.random((params[:limit]|| 1).to_i)
  end
end
