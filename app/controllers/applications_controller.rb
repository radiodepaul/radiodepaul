class ApplicationsController < ApplicationController
  before_filter :authenticate_person!, :except => [:new, :create]
  allowed_roles = Array["Program Director"]
  before_filter :except => [:new, :create] { |c| c.validate_access allowed_roles }
  before_filter :isAdmin?, :only => [:destroy, :edit, :update]
  # GET /applications
  # GET /applications.json
  autocomplete :genre, :name, :class_name => 'ActsAsTaggableOn::Tag'
  
  add_breadcrumb 'Applications', :apps_path
  
  def admin
    if params.has_key?(:app_ids)
      if params[:hire_button]
        params[:app_ids].each do |id|
          @a = Application.find(id)
          @person = Person.new(:email => @a.email, :first_name => @a.first_name, :last_name => @a.last_name, :bio => @a.bio, :facebook_username => @a.facebook_username, :twitter_username => @a.twitter_username, :tumblr_username => @a.tumblr_username, :major => @a.major, :class_year => @a.year, :hometown => "#{@a.home_city}, #{@a.home_state}", :influences => @a.influences, :depaul_id => @a.depaul_id, :password => Devise.friendly_token.first(8))
          @person.replace_avatar_from(@a)
          if @person.save
            @a.hired = true
            @a.rejected = false
            @a.archived = false
            @a.save
          end
        end
        flash[:notice] = "#{params[:app_ids].try(:length)} applicant(s) have been hired"
        redirect_to apps_path
      elsif params[:mark_as_hired_button]
        params[:app_ids].each do |id|
          @a = Application.find(id)
          @a.update_attribute(:hired, true)
          @a.update_attribute(:rejected, false)
          @a.update_attribute(:archived, false)
          @a.save(:validation => false)
        end
        flash[:notice] = "#{params[:app_ids].try(:length)} applicant(s) have been marked as hired"
        redirect_to apps_path
      elsif params[:reject_button]
        if Application.update_all(["rejected=?,archived=?,hired=?", true, false, false], :id => params[:app_ids])
          flash[:notice] = 'Applicants(s) have been rejected'
          redirect_to apps_path
        end
      elsif params[:archive_button]
        if Application.update_all(["archived=?,hired=?,rejected=?", true, false, false], :id => params[:app_ids])
          flash[:notice] = "#{params[:app_ids].length} applicant(s) have been archived"
          redirect_to apps_path
        end
      elsif params[:restore_button]
        if Application.update_all(["archived=?, rejected=?, hired=?", false, false, false], :id => params[:app_ids])
          flash[:notice] = 'Applicant(s) have been restored'
          redirect_to apps_path
        end
      end
    else
        flash[:notice] = 'Please select at least one application.'
        redirect_to apps_path
    end
  end

  def index
    if params.has_key?(:hired) && params[:hired] = 'true'
      @applications = Application.find(:all, :conditions => {:hired => true}, :order => 'created_at desc')
    elsif params.has_key?(:rejected) && params[:rejected] = 'true'
      @applications = Application.find(:all, :conditions => {:rejected => true}, :order => 'created_at desc')
    elsif params.has_key?(:archived) && params[:archived] = 'true'
      @applications = Application.find(:all, :conditions => {:archived => true}, :order => 'created_at desc')
    else
      @applications = Application.find(:all, :conditions => {:archived => false, :hired => false, :rejected => false}, :order => 'created_at desc')
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @applications }
    end
  end

  # GET /applications/1
  # GET /applications/1.json
  def hire
    @a = Application.find(params[:id])
    @person = Person.new(:email => @a.email, :first_name => @a.first_name, :last_name => @a.last_name, :bio => @a.bio, :facebook_username => @a.facebook_username, :twitter_username => @a.twitter_username, :tumblr_username => @a.tumblr_username, :major => @a.major, :class_year => @a.year, :hometown => "#{@a.home_city}, #{@a.home_state}", :influences => @a.influences, :depaul_id => @a.depaul_id, :password => Devise.friendly_token.first(8))
                        
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
    add_breadcrumb "#{@application.first_name} #{@application.last_name}", app_path(@application)

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
        format.html { render 'application_success', :locals => { :first_name => @application.first_name } }
        format.json { render json: @application, status: :created, location: @application }
      else
        format.html { render action: "new" }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  def application_success
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
