class SlotsController < ApplicationController
  before_filter :authenticate_person!, :except => [:new, :create, :getOnAir, :getSchedule, :now_playing]
  allowed_roles = Array["Program Director", "Student General Manager"]
  before_filter :except => [:new, :create, :getOnAir, :getSchedule, :now_playing] { |c| c.validate_access allowed_roles }
  before_filter :isAdmin?, :only => [:destroy]
  before_filter :set_timezone
  # GET /slots
  # GET /slots.json

  add_breadcrumb 'Schedule A Show', :slots_path
  
  def index
    #@slots = Slot.find(:all, :order => 'start_time',  :conditions => ["quarter=?", Settings.active_schedule])
    @q = Slot.search(params[:q])
    @slots = @q.result(:distinct => true)

    respond_to do |format|
      format.html {
          render :html => @slots
      } # show.html.erb
      format.json { render json: @slots, :callback => params[:callback] }
      format.js  { render json: @slots, :callback => params[:callback] }
    end
  end

  # GET /slots/1
  # GET /slots/1.json
  def show
    @slot = Slot.find(params[:id])
    
    add_breadcrumb "#{@slot.quarter} Slot", slot_path(@slot)

    respond_to do |format|
      format.html {
          render :html => @slot
      } # show.html.erb
      format.json { render json: @slot, :callback => params[:callback] }
      format.js  { render :json => @slot, :callback => params[:callback] }
    end
  end

  # GET /slots/new
  # GET /slots/new.json
  def new
    @slot = Slot.new

    respond_to do |format|
      format.html # new.html.erb
      #format.json { render json: @slot }
    end
  end

  # GET /slots/1/edit
  def edit
    @slot = Slot.find(params[:id])
    add_breadcrumb "#{@slot.quarter} Slot", slot_path(@slot)
  end

  # POST /slots
  # POST /slots.json
  def create
    @slot = Slot.new(params[:slot])

    respond_to do |format|
      if @slot.save
        format.html { redirect_to @slot, notice: 'Slot was successfully created.' }
        #format.json { render json: @slot, status: :created, location: @slot }
      else
        format.html { render action: "new" }
        #format.json { render json: @slot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /slots/1
  # PUT /slots/1.json
  def update
    @slot = Slot.find(params[:id])

    respond_to do |format|
      if @slot.update_attributes(params[:slot])
        format.html { redirect_to @slot, notice: 'Slot was successfully updated.' }
        #format.json { head :ok }
      else
        format.html { render action: "edit" }
        #format.json { render json: @slot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /slots/1
  # DELETE /slots/1.json
  def destroy
    @slot = Slot.find(params[:id])
    @slot.destroy

    respond_to do |format|
      format.html { redirect_to slots_url }
      #format.json { head :ok }
    end
  end
  
  def current
    @slots = Slot.find(:all, :order => 'start_time', :conditions => ["quarter=?", Settings.active_schedule])

    respond_to do |format|
      format.html { render json: @slots }
      format.json { render json: @slots, :callback => params[:callback] }
      format.js  { render json: @slots, :callback => params[:callback] }
      format.xml  { render :xml => @slot }
    end
  end

  
  
  def now_playing
        current_day = Time.now.strftime("%A").downcase!
        @slot = Slot.find(:all, :conditions => ["quarter = ? AND start_time <= ? AND end_time >=  ? AND " + current_day + " = 't'", Settings.active_schedule, Time.now, Time.now])
        unless @slot.length > 0 then
          @slot = {
            show: Show.where("title like ?", "%HAL%").first
          }
        end
      if (Settings.override == true)
        @slot.first.show = Show.find(Settings.override_show)
      end
    respond_to do |format|
      format.js { render :json => @slot, :callback => params[:callback] }
      format.json  { render :json => @slot }
      format.xml  { render :xml => @slot }
    end
    
  end

  # API

  def getSchedule

    if params.has_key?(:day)
        @slots = Slot.find(:all, :order => 'start_time', :conditions => ["quarter = ? AND #{params[:day]} = true", Settings.active_schedule])
    else
      @slots = Slot.find(:all, :order => 'start_time', :conditions => ["quarter = ?", Settings.active_schedule])
    end

    respond_to do |format|
      format.html { redirect_to pages_api_path }
      format.json { render json: @slots, :callback => params[:callback] }
      format.js  { render json: @slots, :callback => params[:callback] }
    end
  end

  def getOnAir
    respond_to do |format|
      format.html { redirect_to pages_api_path }
        current_day = Time.now.strftime("%A").downcase!
        @slot = Slot.find(:all, :conditions => ["quarter = ? AND start_time <= ? AND end_time >=  ? AND " + current_day + " = 't'", Settings.active_schedule, Time.now, Time.now]).first
        unless @slot then
          @slot = {
                   start_time: '',
                   end_time: '',
                   quarter: Settings.active_schedule,
                   show: Show.where("title like ?", "%HAL%").first
                  }
        end
      if (Settings.override == true)
        @slot.first.show = Show.find(Settings.override_show)
      end
      format.js { render :json => @slot, :callback => params[:callback] }
      format.json  { render :json => @slot }
    end
  end

end
