class Api::V2::PeopleController < Api::V2::ApiController
  respond_to :json

  def index
    render json: Person.al
  end

  def show
    render json: Person.find(params[:id])
  end

  def create
    render json: Person.create(params[:show])
  end

  def update
    render json: Person.update(params[:id], params[:show])
  end

  def destroy
    render json: Person.destroy(params[:id])
  end

  def random
    render json: Person.random((params[:limit]|| 1).to_i)
  end
end
