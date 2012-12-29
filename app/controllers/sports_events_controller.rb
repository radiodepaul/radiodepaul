class SportsEventsController < ApplicationController
  # GET /sports_events
  # GET /sports_events.json
  def index
    @sports_events = SportsEvent.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sports_events }
    end
  end

  # GET /sports_events/1
  # GET /sports_events/1.json
  def show
    @sports_event = SportsEvent.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sports_event }
    end
  end

  # GET /sports_events/new
  # GET /sports_events/new.json
  def new
    @sports_event = SportsEvent.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sports_event }
    end
  end

  # GET /sports_events/1/edit
  def edit
    @sports_event = SportsEvent.find(params[:id])
  end

  # POST /sports_events
  # POST /sports_events.json
  def create
    @sports_event = SportsEvent.new(params[:sports_event])

    respond_to do |format|
      if @sports_event.save
        format.html { redirect_to @sports_event, notice: 'Sports event was successfully created.' }
        format.json { render json: @sports_event, status: :created, location: @sports_event }
      else
        format.html { render action: "new" }
        format.json { render json: @sports_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sports_events/1
  # PUT /sports_events/1.json
  def update
    @sports_event = SportsEvent.find(params[:id])

    respond_to do |format|
      if @sports_event.update_attributes(params[:sports_event])
        format.html { redirect_to @sports_event, notice: 'Sports event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @sports_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sports_events/1
  # DELETE /sports_events/1.json
  def destroy
    @sports_event = SportsEvent.find(params[:id])
    @sports_event.destroy

    respond_to do |format|
      format.html { redirect_to sports_events_url }
      format.json { head :no_content }
    end
  end
end
