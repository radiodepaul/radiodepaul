class Api::V2::EventsController < Api::V2::ApiController
  respond_to :json

  def index
    respond_with Event.all, root: false
  end

  def show
    respond_with Event.find(params[:id]), root: false
  end

  def create
    respond_with Event.create(params[:show]), root: false
  end

  def update
    respond_with Event.update(params[:id], params[:show]), root: false
  end

  def destroy
    respond_with Event.destroy(params[:id]), root: false
  end
end
