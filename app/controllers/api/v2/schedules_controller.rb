class Api::V2::SchedulesController < Api::V2::ApiController
  respond_to :json

  def index
    respond_with Schedule.all, root: false
  end

  def show
    respond_with Schedule.find_by_code(params[:id]), root: false
  end

  def create
    respond_with Schedule.create!(params[:show]), root: false
  end

  def update
    respond_with Schedule.update(params[:id], params[:show]), root: false
  end

  def destroy
    respond_with Schedule.destroy(params[:id]), root: false
  end

  def current
    respond_with Schedule.current, root: false
  end

  def slots
    if params[:id].downcase == 'current'
      respond_with Schedule.current.slots.sort_by(&:start_time), root: false
    else
      respond_with Schedule.find_by_code(params[:id]).slots, root: false
    end
  end

  def shows
    if params[:id].downcase == 'current'
      respond_with Schedule.current.shows, root: false
    else
      respond_with Schedule.find_by_code(params[:id]).shows, each_serializer: ShortShowSerializer, root: false
    end
  end

  def hosts
    if params[:id].downcase == 'current'
      respond_with Schedule.current.hosts, root: false
    else
      respond_with Schedule.find_by_code(params[:id]).hosts, each_serializer: ShortPersonSerializer, root: false
    end
  end
end
