class Api::V2::NewsPostsController < Api::V2::ApiController
  respond_to :json

  def index
    render json: NewsPost.all
  end

  def show
    render json: NewsPost.find(params[:id])
  end

  def create
    render json: NewsPost.create(params[:show])
  end

  def update
    render json: NewsPost.update(params[:id], params[:show])
  end

  def destroy
    render json: NewsPost.destroy(params[:id])
  end
end
