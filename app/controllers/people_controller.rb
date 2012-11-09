class PeopleController < ApplicationController
  before_filter :authenticate_person!, :except => [:getPerson, :getList, :getRandom]
  allowed_roles = Array['Program Director', 'Student General Manager']
  before_filter :except => [:edit, :update, :show, :index, :getPerson, :getList, :getRandom] { |c| c.validate_access allowed_roles }
  before_filter :isAdmin?, :only => [:destroy]
  # GET /people
  # GET /people.json

  add_breadcrumb 'People', :people_path

  def change_password
    current_user.reset_password!(params[:password], params[:password_confirmation])
    flash[:notice] = "Password changed."
    redirect_to root_path
  end

  def become
    return unless current_person.admin?
    sign_in(:person, Person.find(params[:id]))
    redirect_to root_path # or user_root_url
  end

  def validate_person_access(person)
    allowed_roles = Array["Program Director"]
    if current_person.admin? || allowed_roles.include?(person.position) || current_person  == person
      return true
    end
    flash[:notice] = "You do not have access to this person."
    redirect_to root_path
    return false
  end

  def admin
    if params.has_key?(:person_ids)
      if params[:send_welcome_email_button]
        params[:person_ids].each do |id|
          @person = Person.find(id)
          new_password = Devise.friendly_token.first(8)
          @person.reset_password!(new_password,new_password)
          Notifier.welcome(@person, new_password).deliver
          @person.update_attribute(:welcome_email_sent_at, Time.now.utc)
        end
        flash[:notice] = "Welcome email sent to #{params[:person_ids].length} user(s)."
        redirect_to people_path
      elsif params[:reset_password_button]
        params[:person_ids].each do |id|
          @person = Person.find(id)
          @person.send_reset_password_instructions
        end
        flash[:notice] = "Reset password instructions sent to #{params[:person_ids].length} user(s)."
        redirect_to people_path
      elsif params[:restore_button]
        if Person.update_all(["archived=?", false], :id => params[:person_ids])
          flash[:notice] = 'Person(s) have been restored'
          redirect_to people_path
        end
      elsif params[:archive_button]
        if Person.update_all(["archived=?", true], :id => params[:person_ids])
          flash[:notice] = 'Person(s) have been archived'
          redirect_to people_path
        end
      end
    else
        flash[:notice] = 'Please select at least one person.'
        redirect_to people_path
    end
  end

  def index
    if params.has_key?(:archived) && params[:archived] = 'true'
      @people = Person.find(:all, :conditions => {:archived => true}, :order => 'first_name')
    else
      @people = Person.find(:all, :conditions => {:archived => false}, :order => 'first_name')
    end

    respond_to do |format|
      format.html {
          render :html => @people
      } # show.html.erb
      format.js { render json: @people, :callback => params[:callback] }
      format.json { render json: @people, :callback => params[:callback] }
      format.xml  { render :xml => @people }
    end
  end

  # GET /people/1
  # GET /people/1.json
  def show
    @person = Person.find(params[:id])
    add_breadcrumb @person.first_last_name, @person

    respond_to do |format|
      format.html {
          render :html => @person
      } # show.html.erb
      format.json { render json: @person, :callback => params[:callback] }
      format.js { render json: @person, :callback => params[:callback] }
    end
  end

  # GET /people/new
  # GET /people/new.json
  def new
    @person = Person.new

    respond_to do |format|
      format.html # new.html.erb
      #format.json { render json: @person }
    end
  end

  # GET /people/1/edit
  def edit
    @person = Person.find(params[:id])
    add_breadcrumb @person.first_last_name, @person
    validate_person_access(@person)
  end

  # POST /people
  # POST /people.json
  def create
    @person = Person.new(params[:person])

    respond_to do |format|
      if @person.save
        format.html { redirect_to @person, notice: 'Person was successfully created.' }
        #format.json { render json: @person, status: :created, location: @person }
      else
        format.html { render action: "new" }
        #format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /people/1
  # PUT /people/1.json
  def update
    @person = Person.find(params[:id])
    validate_person_access(@person)

    if !current_person.admin? && current_person.try(:position) != 'Program Director'
      params[:person].delete :hostings_attributes
    end

    respond_to do |format|
      if @person.update_attributes(params[:person])
        format.html { redirect_to @person, notice: 'Person was successfully updated.' }
        #format.json { head :ok }
      else
        format.html { render action: "edit" }
        #format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    @person = Person.find(params[:id])
    @person.destroy

    respond_to do |format|
      format.html { redirect_to people_url }
      #format.json { head :ok }
    end
  end
  
  def random
      person_ids = Person.find( :all, :select => 'id' ).map( &:id )
      @people = Person.find( (1..5).map { person_ids.delete_at( person_ids.size * rand ) } )

      respond_to do |format|
        format.html {
            render :html => @people
        } # show.html.erb
        format.js { render :json => @people, :callback => params[:callback] }
        format.json  { render :json => @people }
        format.xml  { render :xml => @people }
      end
  end
  
  def search
    if params[:search_text] && params[:search_text] != ""
      match_term =  "%" + params[:search_text] + "%"
      @people = Person.find(:all, :conditions => ["first_name like ?", match_term]) + Person.find(:all, :conditions => ["last_name like ?", match_term])
    end
  end

  def getList
    respond_to do |format|
      format.html { redirect_to pages_api_path}
      @people = Person.find(:all, :conditions => {:archived => false}, :order => 'first_name')
      format.js { render json: @people, :callback => params[:callback] }
      format.json { render json: @people, :callback => params[:callback] }
      format.xml  { render :xml => @people }
    end
  end

  # GET /people/1
  # GET /people/1.json
  def getPerson
    respond_to do |format|
      format.html { redirect_to pages_api_path}
      @person = Person.find(params[:id])
      format.json { render json: @person, :callback => params[:callback] }
      format.js { render json: @person, :callback => params[:callback] }
    end
  end

  def getRandom
    respond_to do |format|
      format.html { redirect_to pages_api_path}
      person_ids = Person.find( :all, :conditions => {:archived => false}, :select => 'id' ).map( &:id )
      @people = Person.find( (1..5).map { person_ids.delete_at( person_ids.size * rand ) } )
      format.js { render :json => @people, :callback => params[:callback] }
      format.json  { render :json => @people }
      format.xml  { render :xml => @people }
    end
  end
  
end
