class SchedulingsController < ApplicationController
  # GET /schedulings
  # GET /schedulings.json
  
  respond_to :html, :xml, :json, :js
  
  def index
    @schedulings = Scheduling.all

    respond_to do |format|
      format.html {
        if logged_in?
          render :html => @schedulings
        end
      } # show.html.erb
      #format.json { render json: @schedulings }
      #format.js  { render :json => @schedulings }
    end
  end

  # GET /schedulings/1
  # GET /schedulings/1.json
  def show
    @scheduling = Scheduling.find(params[:id])

    respond_to do |format|
      format.html {
        if logged_in?
          render :html => @scheduling
        end
      } # show.html.erb
      #format.json { render json: @scheduling }
    end
  end

  # GET /schedulings/new
  # GET /schedulings/new.json
  def new
    @scheduling = Scheduling.new

    respond_to do |format|
      format.html # new.html.erb
      #format.json { render json: @scheduling }
    end
  end

  # GET /schedulings/1/edit
  def edit
    @scheduling = Scheduling.find(params[:id])
  end

  # POST /schedulings
  # POST /schedulings.json
  def create
    @scheduling = Scheduling.new(params[:scheduling])

    respond_to do |format|
      if @scheduling.save
        format.html { redirect_to @scheduling, notice: 'Scheduling was successfully created.' }
        #format.json { render json: @scheduling, status: :created, location: @scheduling }
      else
        format.html { render action: "new" }
        #format.json { render json: @scheduling.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /schedulings/1
  # PUT /schedulings/1.json
  def update
    @scheduling = Scheduling.find(params[:id])

    respond_to do |format|
      if @scheduling.update_attributes(params[:scheduling])
        format.html { redirect_to @scheduling, notice: 'Scheduling was successfully updated.' }
        #format.json { head :ok }
      else
        format.html { render action: "edit" }
        #format.json { render json: @scheduling.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /schedulings/1
  # DELETE /schedulings/1.json
  def destroy
    @scheduling = Scheduling.find(params[:id])
    @scheduling.destroy

    respond_to do |format|
      format.html { redirect_to schedulings_url }
      #format.json { head :ok }
    end
  end
end
