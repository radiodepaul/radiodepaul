class Api::V2::PodcastsController < Api::V2::ApiController
  respond_to :json

  def index
    render json: Podcast.all
  end

  def show
    render json: Podcast.find(params[:id])
  end

  def create
    render json: Podcast.create(params[:show])
  end

  def update
    render json: Podcast.update(params[:id], params[:show])
  end

  def destroy
    render json: Podcast.destroy(params[:id])
  end
end
