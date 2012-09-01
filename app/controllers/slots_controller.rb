class SlotsController < ApplicationController
  before_filter :authenticate_person!, :except => [:new, :create]
  allowed_roles = Array["Program Director"]
  before_filter :except => [:new, :create] { |c| c.validate_access allowed_roles }
  before_filter :set_timezone
  # GET /slots
  # GET /slots.json
  
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
    @slots = Slot.find(:all, :order => 'start_time', :conditions => ["quarter=?", "SU2012"])

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
          @slot = [{:show => { :title => "HAL 2012", :id => "10", :hosts => [{:name => "HAL 2012",:id => "58", :photo_thumb => "https://radiodepaul.s3.amazonaws.com/uploads/show/avatar/10/square_thumb_eee65920-911c-4f67-a746-2980cbfb4cc3.jpg"}], :genre => "Indie, College, Hip Hop", :short_description => "Hal 2011 is our automated system that plays when we don't have live shows. Hal is loaded with the newest and best tunes. Enjoy!", :photo => "https://radiodepaul.s3.amazonaws.com/uploads/show/avatar/10/square_small_eee65920-911c-4f67-a746-2980cbfb4cc3.jpg" }
          }]
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
    respond_to do |format|
      format.html { redirect_to pages_api_path }
      @slots = Slot.find(:all, :order => 'start_time', :conditions => ["quarter = ?", "SU2012"])
      format.json { render json: @slots, :callback => params[:callback] }
      format.js  { render json: @slots, :callback => params[:callback] }
    end
  end

  def getOnAir
    respond_to do |format|
      format.html { redirect_to pages_api_path }
        current_day = Time.now.strftime("%A").downcase!
        @slot = Slot.find(:all, :conditions => ["quarter = ? AND start_time <= ? AND end_time >=  ? AND " + current_day + " = 't'", Settings.active_schedule, Time.now, Time.now])
        unless @slot.length > 0 then
          @slot = [{:show => { :title => "HAL 2012", :id => "10", :hosts => [{:name => "HAL 2012",:id => "58", :photo_thumb => "https://radiodepaul.s3.amazonaws.com/uploads/show/avatar/10/square_thumb_eee65920-911c-4f67-a746-2980cbfb4cc3.jpg"}], :genre => "Indie, College, Hip Hop", :short_description => "Hal 2011 is our automated system that plays when we don't have live shows. Hal is loaded with the newest and best tunes. Enjoy!", :photo => "https://radiodepaul.s3.amazonaws.com/uploads/show/avatar/10/square_small_eee65920-911c-4f67-a746-2980cbfb4cc3.jpg" }
          }]
        end
      if (Settings.override == true)
        @slot.first.show = Show.find(Settings.override_show)
      end
      format.js { render :json => @slot, :callback => params[:callback] }
      format.json  { render :json => @slot }
    end
  end

end
