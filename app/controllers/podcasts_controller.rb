class PodcastsController < ApplicationController
  load_and_authorize_resource
  add_breadcrumb 'Podcasts', :podcasts_path

  respond_to :html, :json

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
