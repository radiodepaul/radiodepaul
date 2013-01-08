class Api::V2::EventsController < Api::V2::ApiController
  respond_to :json

  def index
    respond_with Event.all
  end

  def show
    respond_with Event.find(params[:id])
  end

  def create
    respond_with Event.create(params[:show])
  end

  def update
    respond_with Event.update(params[:id], params[:show])
  end

  def destroy
    respond_with Event.destroy(params[:id])
  end
end
