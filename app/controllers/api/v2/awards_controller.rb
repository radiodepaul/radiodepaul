class Api::V2::AwardsController < Api::V2::ApiController
  respond_to :json

  def index
    if id = params[:person_id]
      awards = Person.find(id).awards
    else
      awards = Award.all
    end
    render json: awards, root: false
  end

  def show
    render json: Award.find(params[:id]), root: false
  end

  def create
    render json: Award.create(params[:show]), root: false
  end

  def update
    render json: Award.update(params[:id], params[:show]), root: false
  end

  def destroy
    render json: Award.destroy(params[:id]), root: false
  end
end
