class ApplicationsController < ApplicationController
  before_filter :authenticate_person!, :except => [:new, :create]
  allowed_roles = Array["Program Director"]
  before_filter :except => [:new, :create] { |c| c.validate_access allowed_roles }
  before_filter :isAdmin?, :only => [:destroy, :edit]
  # GET /applications
  # GET /applications.json
  autocomplete :genre, :name, :class_name => 'ActsAsTaggableOn::Tag'
  def index
    @applications = Application.find(:all, :order => 'created_at desc')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @applications }
    end
  end

  # GET /applications/1
  # GET /applications/1.json
  def hire
    application = Application.find(params[:id])
    person = Person.new
    person.email = application.email
    person.first_name = application.first_name
    person.last_name = application.last_name
    person.bio = application.bio
    person.facebook_username = application.facebook_username
    person.twitter_username = application.twitter_username
    person.tumblr_username = application.tumblr_username
    person.major = application.major
    person.class_year = application.year
    person.hometown = "#{application.home_city}, #{application.home_state}"
    person.influences = application.influences
    #person.nickname = application.nickname
    #person.website_url = application.website_url

  end
  def show
    @application = Application.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @application }
    end
  end

  # GET /applications/new
  # GET /applications/new.json
  def new
    @application = Application.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @application }
    end
  end

  # GET /applications/1/edit
  def edit
    @application = Application.find(params[:id])
  end

  # POST /applications
  # POST /applications.json
  def create
    @application = Application.new(params[:application])

    respond_to do |format|
      if @application.save
        Notifier.application_confirmation(@application).deliver
        format.html { redirect_to :controller => 'pages', :action => 'application_success', notice: 'Application was successfully created.' }
        format.json { render json: @application, status: :created, location: @application }
      else
        format.html { render action: "new" }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /applications/1
  # PUT /applications/1.json
  def update
    @application = Application.find(params[:id])

    respond_to do |format|
      if @application.update_attributes(params[:application])
        format.html { redirect_to @application, notice: 'Application was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /applications/1
  # DELETE /applications/1.json
  def destroy
    @application = Application.find(params[:id])
    @application.destroy

    respond_to do |format|
      format.html { redirect_to applications_url }
      format.json { head :no_content }
    end
  end
end
