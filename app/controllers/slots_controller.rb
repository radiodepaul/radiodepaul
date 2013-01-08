class SlotsController < ApplicationController
  allowed_roles = Array['Program Director']

  before_filter :authenticate_person!, :except => [:new, :create, :getOnAir, :getSchedule, :now_playing]
  before_filter :except => [:new, :create, :getOnAir, :getSchedule, :now_playing] { |c| c.validate_access allowed_roles }
  before_filter :isAdmin?, :only => [:destroy]
  before_filter :set_timezone

  add_breadcrumb 'Schedule A Show', :slots_path
  
  def index
    @q = Slot.search(params[:q])
    @slots = @q.result(:distinct => true)

    respond_to do |format|
      format.html {
          render :html => @slots
      }
      format.json { render json: @slots, :callback => params[:callback] }
      format.js  { render json: @slots, :callback => params[:callback] }
    end
  end

  def show
    @slot = Slot.find(params[:id])
    
    add_breadcrumb "#{@slot.quarter} Slot", slot_path(@slot)

    respond_to do |format|
      format.html {
          render :html => @slot
      }
      format.json { render json: @slot, :callback => params[:callback] }
      format.js  { render :json => @slot, :callback => params[:callback] }
    end
  end

  def new
    @slot = Slot.new

    respond_to do |format|
      format.html
    end
  end

  def edit
    @slot = Slot.find(params[:id])
    add_breadcrumb "#{@slot.quarter} Slot", slot_path(@slot)
  end

  def create
    @slot = Slot.new(params[:slot])

    respond_to do |format|
      if @slot.save
        format.html { redirect_to @slot, notice: 'Slot was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    @slot = Slot.find(params[:id])

    respond_to do |format|
      if @slot.update_attributes(params[:slot])
        format.html { redirect_to @slot, notice: 'Slot was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    @slot = Slot.find(params[:id])
    @slot.destroy

    respond_to do |format|
      format.html { redirect_to slots_url }
    end
  end
  
  def current
    @slots = Slot.active

    respond_to do |format|
      format.html { render json: @slots }
      format.json { render json: @slots, :callback => params[:callback] }
      format.js  { render json: @slots, :callback => params[:callback] }
      format.xml  { render :xml => @slot }
    end
  end

  # API

  def getSchedule
    @slots = Slot.active

    respond_to do |format|
      format.html { redirect_to pages_api_path }
      format.json { render json: @slots, :callback => params[:callback] }
      format.js  { render json: @slots, :callback => params[:callback] }
    end
  end

  def getOnAir
    @slot = Slot.on_air

    respond_to do |format|
      format.html { redirect_to pages_api_path }
      format.js { render :json => @slot, :callback => params[:callback] }
      format.json  { render :json => @slot }
    end
  end
end
