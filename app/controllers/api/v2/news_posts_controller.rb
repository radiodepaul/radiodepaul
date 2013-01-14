class Api::V2::NewsPostsController < Api::V2::ApiController
  respond_to :json

  def index
    render json: NewsPost.all, root: false
  end

  def show
    render json: NewsPost.find(params[:id]), root: false
  end

  def create
    render json: NewsPost.create(params[:show]), root: false
  end

  def update
    render json: NewsPost.update(params[:id], params[:show]), root: false
  end

  def destroy
    render json: NewsPost.destroy(params[:id]), root: false
  end
end
