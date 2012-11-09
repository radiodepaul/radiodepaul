class ManagersController < ApplicationController
  before_filter :authenticate_person!, :except => [:getManagers]
  allowed_roles = Array["Program Director"]
  before_filter :except => [:index, :show, :getManagers] { |c| c.validate_access allowed_roles}
  before_filter :isAdmin?, :only => [:destroy]
  # GET /managers
  # GET /managers.json
  
  add_breadcrumb 'Managers', :managers_path
  
  def index
    @managers = Manager.all

    respond_to do |format|
      format.html {
          render :html => @managers
      } # show.html.erb
      format.json { render json: @managers, :callback => params[:callback] }
      format.js { render json: @managers, :callback => params[:callback] }
    end
  end

  # GET /managers/1
  # GET /managers/1.json
  def show
    @manager = Manager.find(params[:id])
    add_breadcrumb @manager.person.try(:first_last_name), manager_path(@manager)

    respond_to do |format|
      format.html {
          render :html => @manager
      } # show.html.erb
      format.json { render json: @manager, :callback => params[:callback] }
      format.js { render json: @manager, :callback => params[:callback] }
    end
  end

  # GET /managers/new
  # GET /managers/new.json
  def new
    @manager = Manager.new

    respond_to do |format|
      format.html # new.html.erb
      #format.json { render json: @manager }
    end
  end

  # GET /managers/1/edit
  def edit
    @manager = Manager.find(params[:id])
  end

  # POST /managers
  # POST /managers.json
  def create
    @manager = Manager.new(params[:manager])

    respond_to do |format|
      if @manager.save
        format.html { redirect_to @manager, notice: 'Manager was successfully created.' }
        #format.json { render json: @manager, status: :created, location: @manager }
      else
        format.html { render action: "new" }
        #format.json { render json: @manager.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /managers/1
  # PUT /managers/1.json
  def update
    @manager = Manager.find(params[:id])

    respond_to do |format|
      if @manager.update_attributes(params[:manager])
        format.html { redirect_to @manager, notice: 'Manager was successfully updated.' }
        #format.json { head :ok }
      else
        format.html { render action: "edit" }
        #format.json { render json: @manager.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def random
      @managers = Manager.find(:all, :order => 'random()')

      respond_to do |format|
        format.html {
            render :html => @managers
        } # show.html.erb
        format.js { render :json => @managers, :callback => params[:callback] }
        format.json  { render :json => @managers }
        format.xml  { render :xml => @managers }
      end
  end
  
  # DELETE /managers/1
  # DELETE /managers/1.json
  def destroy
    @manager = Manager.find(params[:id])
    @manager.destroy

    respond_to do |format|
      format.html { redirect_to managers_url }
      #format.json { head :ok }
    end
  end

def getManagers
    respond_to do |format|
      format.html { redirect_to pages_api_path}
      if params[:id] == "normal"
        @managers = Manager.all
      else
        @managers = Manager.find(:all, :order => 'random()')
      end
      format.json { render json: @managers, :callback => params[:callback] }
      format.js { render json: @managers, :callback => params[:callback] }
    end
  end

end
