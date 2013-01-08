class ManagersController < ApplicationController

  before_filter :authenticate_person!, :except => [:getManagers]
  before_filter :except => [:index, :show, :getManagers] { |c| c.validate_access }
  before_filter :isAdmin?, :only => [:destroy]
  
  add_breadcrumb 'Managers', :managers_path

  def index
    @managers = Manager.all

    respond_to do |format|
      format.html { render :html => @managers }
      format.json { render json: @managers, :callback => params[:callback] }
      format.js { render json: @managers, :callback => params[:callback] }
    end
  end

  def show
    @manager = Manager.find(params[:id])
    add_breadcrumb @manager.person.try(:name), manager_path(@manager)

    respond_to do |format|
      format.html { render :html => @manager }
      format.json { render json: @manager, :callback => params[:callback] }
      format.js { render json: @manager, :callback => params[:callback] }
    end
  end

  def new
    @manager = Manager.new

    respond_to do |format|
      format.html
    end
  end

  def edit
    @manager = Manager.find(params[:id])
  end

  def create
    @manager = Manager.new(params[:manager])

    respond_to do |format|
      if @manager.save
        format.html { redirect_to @manager, notice: 'Manager was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @manager = Manager.find(params[:id])

    respond_to do |format|
      if @manager.update_attributes(params[:manager])
        format.html { redirect_to @manager, notice: 'Manager was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end
  
  def random
      @managers = Manager.find(:all, :order => 'random()')

      respond_to do |format|
        format.html { render :html => @managers }
        format.js { render :json => @managers, :callback => params[:callback] }
        format.json  { render :json => @managers }
        format.xml  { render :xml => @managers }
      end
  end
  
  def destroy
    @manager = Manager.find(params[:id])
    @manager.destroy

    respond_to do |format|
      format.html { redirect_to managers_url }
    end
  end
end
