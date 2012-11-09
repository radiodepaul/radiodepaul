class PodcastsController < ApplicationController
  before_filter :authenticate_person!, :except => [:getPodcasts]
  allowed_roles = Array["Podcast Programmer", "Student General Manager"]
  before_filter :except => [:index, :new, :create, :show, :edit, :update, :getPodcasts] { |c| c.validate_access allowed_roles }
  before_filter :isAdmin?, :only => [:destroy]
  # GET /podcasts
  # GET /podcasts.json

  add_breadcrumb 'Podcasts', :podcasts_path
  
  def validate_podcast_access(podcast)
    allowed_roles = Array["Podcast Programmer"]
    if current_person.admin? || allowed_roles.include?(Manager.find_by_person_id(current_person.id).position) || current_person.try(:podcasts).include?(podcast)
      return true
    end
    flash[:notice] = "You do not have access to this podcast."
    redirect_to root_path
    return false
  end
  
  def index
    @podcasts = Podcast.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @podcasts }
      format.js  { render :json => @podcasts, :callback => params[:callback] }
    end
  end

  # GET /podcasts/1
  # GET /podcasts/1.json
  def show
    @podcast = Podcast.find(params[:id])
    add_breadcrumb @podcast.title, podcast_path(@podcast)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @podcast }
    end
  end

  # GET /podcasts/new
  # GET /podcasts/new.json
  def new
    @podcast = Podcast.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @podcast }
    end
  end

  # GET /podcasts/1/edit
  def edit
    @podcast = Podcast.find(params[:id])
    add_breadcrumb @podcast.title, podcast_path(@podcast)
    validate_podcast_access(@podcast)
  end

  # POST /podcasts
  # POST /podcasts.json
  def create
    @podcast = Podcast.new(params[:podcast])

    respond_to do |format|
      if @podcast.save
        format.html { redirect_to @podcast, notice: 'Podcast was successfully created.' }
        format.json { render json: @podcast, status: :created, location: @podcast }
      else
        format.html { render action: "new" }
        format.json { render json: @podcast.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /podcasts/1
  # PUT /podcasts/1.json
  def update
    @podcast = Podcast.find(params[:id])
    validate_podcast_access(@podcast)

    respond_to do |format|
      if @podcast.update_attributes(params[:podcast])
        format.html { redirect_to @podcast, notice: 'Podcast was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @podcast.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /podcasts/1
  # DELETE /podcasts/1.json
  def destroy
    @podcast = Podcast.find(params[:id])
    @podcast.destroy

    respond_to do |format|
      format.html { redirect_to podcasts_url }
      format.json { head :ok }
    end
  end

  def getPodcasts
    respond_to do |format|
      format.html { redirect_to pages_api_path}
      @podcasts = Podcast.all
      format.json { render json: @podcasts, :callback => params[:callback] }
      format.js  { render :json => @podcasts, :callback => params[:callback] }
    end
  end

end
