class Api::V2::SlotsController < Api::V2::ApiController
  respond_to :json

  def index
    render json: Slot.all, root: false
  end

  def show
    render json: Slot.find(params[:id]), root: false
  end

  def create
    render json: Slot.create(params[:slot]), root: false
  end

  def update
    render json: Slot.update(params[:id], params[:slot]), root: false
  end

  def destroy
    render json: Slot.destroy(params[:id]), root: false
  end

  def on_air
    render json Slot.on_air, root: false
  end

  def random
    render json: Slot.random((params[:limit]|| 1).to_i), root: false
  end
end
