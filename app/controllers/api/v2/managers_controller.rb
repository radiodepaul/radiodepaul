class Api::V2::ManagersController < Api::V2::ApiController
  respond_to :json

  def index
    render json: Person.managers, root: false
  end

  def show
    render json: Person.managers.find(params[:id]), root: false
  end

  def create
    render json: Person.managers.create(params[:show]), root: false
  end

  def update
    render json: Person.managers.update(params[:id], params[:show]), root: false
  end

  def destroy
    render json: Person.managers.destroy(params[:id]), root: false
  end

  def random
    render json: Person.managers.random((params[:limit]|| 1).to_i), root: false
  end
end
