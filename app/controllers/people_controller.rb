class PeopleController < ApplicationController

  allowed_roles = Array['Program Director']
  before_filter :authenticate_person!
  before_filter :isAdmin?, :only => [:destroy]

  add_breadcrumb 'People', :people_path

  def change_password
    current_user.reset_password!(params[:password], params[:password_confirmation])
    flash[:notice] = 'Password changed.'
    redirect_to root_path
  end

  def become
    return unless current_person.admin?
    sign_in(:person, Person.find(params[:id]))
    redirect_to root_path
  end

  def reset_password
    params.fetch(:person_ids, []).each do |id|
      Person.find(id).reset_password!
    end

    flash[:notice] = "Welcome email sent to #{params[:person_ids].length} user(s)."
    redirect_to people_path
  end

  def send_password_reset
    params.fetch(:person_ids, []).each do |id|
      Person.find(id).send_reset_password_instructions
    end

    flash[:notice] = "Reset password instructions sent to #{params[:person_ids].length} user(s)."
    redirect_to people_path
  end

  def archive
    Person.update_all(['archived=?', true], :id => params[:person_ids])

    flash[:notice] = 'Person(s) have been archived'
    redirect_to people_path
  end

  def restore
    Person.update_all(['archived=?', false], :id => params[:person_ids])

    flash[:notice] = 'Person(s) have been restored'
    redirect_to people_path
  end

  def index
    @link_text = params[:archived] ? 'Archived' : 'Active'
    @href      = params[:archived] ? people_path : people_path(archived: true)
    @people    = params[:archived] ? Person.archived : Person.active

    respond_to do |format|
      format.html { render :html => @people }
      format.js
      format.json { render json: @people, :callback => params[:callback] }
    end
  end

  def show
    @person = Person.find(params[:id])
    add_breadcrumb @person.name, @person

    respond_to do |format|
      format.html {
          render :html => @person
      }
      format.json { render json: @person, :callback => params[:callback] }
      format.js { render json: @person, :callback => params[:callback] }
    end
  end

  def new
    @person = Person.new

    respond_to do |format|
      format.html
    end
  end

  def edit
    @person = Person.find(params[:id])
    add_breadcrumb @person.fullname, @person
  end

  def create
    @person = Person.new(params[:person])

    respond_to do |format|
      if @person.save
        format.html { redirect_to @person, notice: 'Person was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @person = Person.find(params[:id])

    if !current_person.admin?
      params[:person].delete :hostings_attributes
    end

    respond_to do |format|
      if @person.update_attributes(params[:person])
        format.html { redirect_to @person, notice: 'Person was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    @person = Person.find(params[:id])
    @person.destroy

    respond_to do |format|
      format.html { redirect_to people_url }
    end
  end

  def search
    if params[:search_text] && params[:search_text] != ''
      match_term = "%#{params[:search_text]}%"

      @people = Person.find(:all, :conditions => ['first_name like ?', match_term]) +
                Person.find(:all, :conditions => ['last_name like ?', match_term])
    end
  end
end
