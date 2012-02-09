class ShowsController < ApplicationController
  # GET /shows
  # GET /shows.json
  
  respond_to :html, :xml, :json, :js
  
  def index
    @shows = Show.find(:all, :order => 'title')

    respond_to do |format|
      format.html {
        if logged_in?
          render :html => @shows
        end
      } # show.html.erb
      format.js  { render :json => @shows, :callback => params[:callback] }
      format.json  { render :json => @shows }
      format.xml  { render :xml => @shows }
    end

  end

  # GET /shows/1
  # GET /shows/1.json
  def show
    @show = Show.find(params[:id])

    respond_to do |format|
      format.html {
        if logged_in?
          render :html => @shows
        end
      } # show.html.erb
      format.js  { render :json => @show, :callback => params[:callback] }
      format.json  { render :json => @show }
      format.xml  { render :xml => @show }
    end
    
  end

  # GET /shows/new
  # GET /shows/new.json
  def new
    if logged_in?
      @show = Show.new

      respond_with(@show) do |format|
        #format.js  { render :json => @show.to_json(:include=>[:people]), :callback => params[:callback] }
      end
    end
  end
  

  # GET /shows/1/edit
  def edit
    if logged_in?
      @show = Show.find(params[:id])
    end
  end

  # POST /shows
  # POST /shows.json
  def create
    if logged_in?
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
  end

  # PUT /shows/1
  # PUT /shows/1.json
  def update
    if logged_in?
      @show = Show.find(params[:id])

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
    if logged_in?
      @show = Show.find(params[:id])
      @show.destroy

      respond_to do |format|
        format.html { redirect_to shows_url }
        #format.json { head :ok }
      end
    end
  end
  
  def random
      show_ids = Show.find( :all, :select => 'id' ).map( &:id )
      @shows = Show.find( (1..5).map { show_ids.delete_at( show_ids.size * rand ) } )

      respond_to do |format|
        format.html {
            render :html => @shows
        } # show.html.erb
        format.js { render :json => @shows, :callback => params[:callback] }
        format.json  { render :json => @shows }
        format.xml  { render :xml => @shows }
      end
  end
  
  def search
    if params[:search_text] && params[:search_text] != ""
      match_term =  "%" + params[:search_text] + "%"
      @shows = Show.find(:all, :conditions => ["title like ?", match_term])
    end
  end
  
end
