class Api::V2::SlotsController < Api::V2::ApiController
  respond_to :json

  def index
    render json: Slot.all
  end

  def show
    render json: Slot.find(params[:id])
  end

  def create
    render json: Slot.create(params[:slot])
  end

  def update
    render json: Slot.update(params[:id], params[:slot])
  end

  def destroy
    render json: Slot.destroy(params[:id])
  end

  def on_air
    render json Slot.on_air
  end

  def random
    render json: Slot.random((params[:limit]|| 1).to_i)
  end
end
