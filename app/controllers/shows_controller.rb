class ShowsController < ApplicationController
  before_filter :authenticate_person!, :except => [:getShow, :getList, :getRandom]
  allowed_roles = Array["Program Director", "Student General Manager"]
  before_filter :only => [:new, :create] { |c| c.validate_access allowed_roles }
  before_filter :isAdmin?, :only => [:destroy]
  # GET /shows
  # GET /shows.json
  
  autocomplete :genre, :name, :class_name => 'ActsAsTaggableOn::Tag'
  add_breadcrumb 'Shows', :shows_path

  def validate_show_access(show)
    allowed_roles = Array["Program Director"]
    if current_person.admin? || allowed_roles.include?(Manager.find_by_person_id(current_person.id).try(:position)) || current_person.try(:shows).include?(show)
      return true
    end
    flash[:notice] = "You do not have access to this show."
    redirect_to root_path
    return false
  end
  
  def index
    if params.has_key?(:archived) && params[:archived] = 'true'
      @shows = Show.find(:all, :conditions => {:archived => true}, :order => 'title desc')
    else
      @shows = Show.find(:all, :conditions => {:archived => false}, :order => 'title desc')
    end

    respond_to do |format|
      format.html {
          render :html => @shows
      } # show.html.erb
      format.js  { render :json => @shows, :callback => params[:callback] }
      format.json  { render :json => @shows }

  end

  def admin
    if params.has_key?(:show_ids)
      if params[:restore_button]
        if Show.update_all(["archived=?", false], :id => params[:show_ids])
          flash[:notice] = 'Show(s) have been restored'
          redirect_to shows_path
        end
      elsif params[:archive_button]
        if Show.update_all(["archived=?", true], :id => params[:show_ids])
          flash[:notice] = 'Show(s) have been archived'
          redirect_to shows_path
        end
      end
    else
        flash[:notice] = 'Please select at least one show.'
        redirect_to shows_path
    end
  end
  # GET /shows/1
  # GET /shows/1.json
  def show
    @show = Show.find(params[:id])
    add_breadcrumb @show.title, @show
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

    respond_to do |format|
      format.html # new.html.erb
      #format.json { render json: @person }
    end
  end
  

  # GET /shows/1/edit
  def edit
      @show = Show.find(params[:id])
      add_breadcrumb @show.title, @show
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

      if !current_person.admin? && current_person.try(:position) != 'Program Director'
        params[:show].delete :hostings_attributes
      end

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
      @shows = Show.find(:all, :conditions => {:archived => false}, :order => 'title')
      format.js  { render :json => @shows, :callback => params[:callback] }
      format.json  { render :json => @shows }
    end
  end

  def getRandom
    respond_to do |format|
      format.html { redirect_to pages_api_path}
      show_ids = Show.find( :all, :conditions => {:archived => false}, :select => 'id' ).map( &:id )
      @shows = Show.find( (1..5).map { show_ids.delete_at( show_ids.size * rand ) } )
      format.js { render :json => @shows, :callback => params[:callback] }
      format.json  { render :json => @shows }
    end
  end
  
end
