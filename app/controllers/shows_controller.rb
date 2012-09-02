class ShowsController < ApplicationController
  before_filter :authenticate_person!, :except => [:getShow, :getList, :getRandom]
  allowed_roles = Array["Program Director"]
  before_filter :except => [:new, :create, :getShow, :getList, :getRandom] { |c| c.validate_access allowed_roles }
  # GET /shows
  # GET /shows.json
  
  autocomplete :genre, :name, :class_name => 'ActsAsTaggableOn::Tag'

  def validate_show_access(show)
    unless current_person.admin? || current_person.try(:shows).include? show then
      flash[:error] = "You do not have access to this show."
      redirect_to root_path
      return false
    end
    return true
  end
  
  def index
      @shows = Show.find(:all, :order => 'title desc')

    respond_to do |format|
      format.html {
          render :html => @shows
      } # show.html.erb
      format.js  { render :json => @shows, :callback => params[:callback] }
      format.json  { render :json => @shows }
    end

  end

  # GET /shows/1
  # GET /shows/1.json
  def show
    @show = Show.find(params[:id])
      if validate_show_access(@show)
        respond_to do |format|
          format.html {
              render :html => @show
          } # show.html.erb
          format.json { render :json => @show.to_json }
        end
      end
  end

  # GET /shows/new
  # GET /shows/new.json
  def new
      @show = Show.new

      respond_with(@show) do |format|
        #format.js  { render :json => @show.to_json(:include=>[:people]), :callback => params[:callback] }
      end
  end
  

  # GET /shows/1/edit
  def edit
      @show = Show.find(params[:id])
      validate_show_access(@show)
  end

  # POST /shows
  # POST /shows.json
  def create
      @show = Show.new(params[:show])

      respond_to do |format|
        if @show.save
          format.html { redirect_to @show, notice: 'Show was successfully created.' }
          #format.json { render json: @show, status: :created, location: @show }
        else
          format.html { render action: "new" }
          #format.json { render json: @show.errors, status: :unprocessable_entity }
        end
      end
  end

  # PUT /shows/1
  # PUT /shows/1.json
  def update
      @show = Show.find(params[:id])

      if validate_show_access(@show)
        respond_to do |format|
          if @show.update_attributes(params[:show])
            format.html { redirect_to @show, notice: 'Show was successfully updated.' }
            #format.json { head :ok }
          else
            format.html { render action: "edit" }
            #format.json { render json: @show.errors, status: :unprocessable_entity }
          end
        end
      end
  end

  # DELETE /shows/1
  # DELETE /shows/1.json
  def destroy
      @show = Show.find(params[:id])
      @show.destroy

      respond_to do |format|
        format.html { redirect_to shows_url }
        #format.json { head :ok }
      end
  end
  
  def random
      show_ids = Show.find( :all, :select => 'id' ).map( &:id )
      @shows = Show.find( (1..5).map { show_ids.delete_at( show_ids.size * rand ) } )

      respond_to do |format|
        format.html {
            render :html => @shows
        }
        format.js { render :json => @shows, :callback => params[:callback] }
        format.json  { render :json => @shows }
      end
  end
  
  def search
    if params[:search_text] && params[:search_text] != ""
      match_term =  "%" + params[:search_text] + "%"
      @shows = Show.find(:all, :conditions => ["title like ?", match_term])
    end
  end

  def getShow
    respond_to do |format|
      format.html { redirect_to pages_api_path}
      @show = Show.find(params[:id])
      format.js  { render :json => @show, :callback => params[:callback] }
      format.json  { render :json => @show }
    end
  end

  def getList
    respond_to do |format|
      format.html { redirect_to pages_api_path}
      @shows = Show.find(:all, :order => 'title')
      format.js  { render :json => @shows, :callback => params[:callback] }
      format.json  { render :json => @shows }
    end
  end

  def getRandom
    respond_to do |format|
      format.html { redirect_to pages_api_path}
      show_ids = Show.find( :all, :select => 'id' ).map( &:id )
      @shows = Show.find( (1..5).map { show_ids.delete_at( show_ids.size * rand ) } )
      format.js { render :json => @shows, :callback => params[:callback] }
      format.json  { render :json => @shows }
    end
  end
  
end
