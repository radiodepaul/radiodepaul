class PodcastsController < ApplicationController

  before_filter :setAccess
  before_filter :authenticate_person!, :except => [:getPodcasts]
  allowed_roles = Array["Podcast Programmer"]
  before_filter :except => [:index, :new, :create, :show, :edit, :update, :getPodcasts] { |c| c.validate_access allowed_roles }
  before_filter :isAdmin?, :only => [:destroy]

  add_breadcrumb 'Podcasts', :podcasts_path

  respond_to :html, :json

  def setAccess
    @allowed_roles = ['Podcast Programmer']
  end
  
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

    respond_with(@podcasts)
  end

  def show
    @podcast = Podcast.find(params[:id])
    add_breadcrumb @podcast.title, podcast_path(@podcast)

    respond_with(@podcast)
  end

  def new
    @podcast = Podcast.new

    respond_with(@podcast)
  end

  def edit
    @podcast = Podcast.find(params[:id])
    add_breadcrumb @podcast.title, podcast_path(@podcast)
    validate_podcast_access(@podcast)

    respond_with(@podcast)
  end

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

  def destroy
    @podcast = Podcast.find(params[:id])
    @podcast.destroy

    respond_to do |format|
      format.html { redirect_to podcasts_url }
      format.json { head :ok }
    end
  end
end
