class Api::V2::ShowsController < Api::V2::ApiController
  respond_to :json

  def index
    if id = params[:person_id]
      shows = Person.find(id).shows.active
    else
      shows = Show.active
    end
    render json: shows, root: false
  end

  def show
    render json: Show.find(params[:id]), root: false
  end

  def create
    render json: Show.create(params[:show]), root: false
  end

  def update
    render json: Show.update(params[:id], params[:show]), root: false
  end

  def destroy
    render json: Show.destroy(params[:id]), root: false
  end

  def random
    render json: Show.random((params[:limit]|| 1).to_i), root: false
  end

  def archived
    render json: Show.archived, root: false
  end
end
