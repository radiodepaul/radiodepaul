class Api::V2::PodcastsController < Api::V2::ApiController
  respond_to :json

  def index
    if id = params[:person_id]
      podcasts = Person.find(id).podcasts
    elsif id = params[:show_id]
      podcasts = Show.find(id).podcasts
    else
      podcasts = Podcast.all
    end
    render json: podcasts, root: false
  end

  def show
    render json: Podcast.find(params[:id]), root: false
  end

  def create
    render json: Podcast.create!(params[:show]), root: false
  end

  def update
    render json: Podcast.update(params[:id], params[:show]), root: false
  end

  def destroy
    render json: Podcast.destroy(params[:id]), root: false
  end
end
