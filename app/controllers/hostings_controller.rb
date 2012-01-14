class HostingsController < ApplicationController
  # GET /hostings
  # GET /hostings.json
  def index
    @hostings = Hosting.all

    respond_to do |format|
      format.html {
        if logged_in?
          render :html => @hostings
        end
      } # show.html.erb
      #format.json { render json: @hostings }
    end
  end

  # GET /hostings/1
  # GET /hostings/1.json
  def show
    @hosting = Hosting.find(params[:id])

    respond_to do |format|
      format.html {
        if logged_in?
          render :html => @hosting
        end
      } # show.html.erb
      #format.json { render json: @hosting }
    end
  end

  # GET /hostings/new
  # GET /hostings/new.json
  def new
    @hosting = Hosting.new

    respond_to do |format|
      format.html # new.html.erb
      #format.json { render json: @hosting }
    end
  end

  # GET /hostings/1/edit
  def edit
    @hosting = Hosting.find(params[:id])
  end

  # POST /hostings
  # POST /hostings.json
  def create
    @hosting = Hosting.new(params[:hosting])

    respond_to do |format|
      if @hosting.save
        format.html { redirect_to @hosting, notice: 'Hosting was successfully created.' }
        #format.json { render json: @hosting, status: :created, location: @hosting }
      else
        format.html { render action: "new" }
        #format.json { render json: @hosting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /hostings/1
  # PUT /hostings/1.json
  def update
    @hosting = Hosting.find(params[:id])

    respond_to do |format|
      if @hosting.update_attributes(params[:hosting])
        format.html { redirect_to @hosting, notice: 'Hosting was successfully updated.' }
        #format.json { head :ok }
      else
        format.html { render action: "edit" }
        #format.json { render json: @hosting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hostings/1
  # DELETE /hostings/1.json
  def destroy
    @hosting = Hosting.find(params[:id])
    @hosting.destroy

    respond_to do |format|
      format.html { redirect_to hostings_url }
      #format.json { head :ok }
    end
  end
end
