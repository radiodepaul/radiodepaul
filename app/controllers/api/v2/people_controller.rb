class Api::V2::PeopleController < Api::V2::ApiController
  respond_to :json

  def index
    if id = params[:show_id]
      people = Show.find(id).hosts
    else
      people = Person.all
    end
    render json: people, root: false
  end

  def show
    render json: Person.find(params[:id]), root: false
  end

  def create
    render json: Person.create!(params[:show]), root: false
  end

  def update
    render json: Person.update(params[:id], params[:show]), root: false
  end

  def destroy
    render json: Person.destroy(params[:id]), root: false
  end

  def random
    render json: Person.random((params[:limit]|| 1).to_i), root: false
  end

  def archived
    render json: Person.archived, root: false
  end
end
