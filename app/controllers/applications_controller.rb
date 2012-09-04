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
    @a = Application.find(params[:id])
    @person = Person.new(:email => @a.email, :first_name => @a.first_name, :last_name => @a.last_name, :bio => @a.bio, :facebook_username => @a.facebook_username,
                        :twitter_username => @a.twitter_username, :tumblr_username => @a.tumblr_username, :major => @a.major, :class_year => @a.year, 
                        :hometown => "#{@a.home_city}, #{@a.home_state}", :influences => @a.influences, :password => Devise.friendly_token.first(8))

    @person.replace_avatar_from(@a)
    respond_to do |format|
      if @person.save
        #Notifier.application_confirmation(@application).deliver
        format.html { redirect_to @person, notice: 'Person was successfully hired.' }
      else
        format.html { redirect_to applications_path, notice: @person.errors.first }
      end
    end
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
      format.html { redirect_to applications_url, notice: 'Application was successfully deleted.' }
      format.json { head :no_content }
    end
  end
end
