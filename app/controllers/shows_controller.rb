class ShowsController < ApplicationController

  before_filter :authenticate_person!
  before_filter :only => [:new, :create] { |c| c.validate_access allowed_roles }
  before_filter :isAdmin?, :only => [:destroy]
  before_filter :setAccess

  respond_to :html, :json
  
  autocomplete :genre, :name, :class_name => 'ActsAsTaggableOn::Tag'
  add_breadcrumb 'Shows', :shows_path

  def setAccess
    @allowed_roles = ['Program Director']
    validate_access @allowed_roles
  end

  def validate_show_access(show)
    if current_person.admin?  || @allowed_roles.include?(Manager.find_by_person_id(current_person.id).try(:position)) || current_person.try(:shows).include?(show)
      return true
    end
    flash[:notice] = 'You do not have access to this show.'
    redirect_to root_path
    return false
  end
  
  def index
    if params.has_key?(:archived) && params[:archived] = 'true'
      @shows = Show.archived.sort_by(&:title)
    else
      @shows = Show.all.sort_by(&:title)
    end

    respond_with(@shows)
  end

  def admin
    if params.has_key?(:show_ids)
      if params[:restore_button]
        if Show.update_all(['archived=?', false], id: params[:show_ids])
          flash[:notice] = 'Show(s) have been restored'
        end
      elsif params[:archive_button]
        if Show.update_all(['archived=?', true], id: params[:show_ids])
          flash[:notice] = 'Show(s) have been archived'
        end
      end
    else
        flash[:notice] = 'Please select at least one show.'
    end

    redirect_to shows_path
  end

  def show
    @show = Show.find(params[:id])
    add_breadcrumb @show.title, @show

    respond_with(@show)
  end

  def new
    @show = Show.new

    respond_with(@show)
  end
  

  def edit
    @show = Show.find(params[:id])

    add_breadcrumb @show.title, @show
    validate_show_access(@show)

    respond_with(@show)
  end

  def create
    @show = Show.new(params[:show])

    respond_with(@show)
  end

  def update
    @show = Show.find(params[:id])

    unless current_person.admin? || current_person.holds_position('Program Director')
      params[:show].delete :hostings_attributes
    end

    if validate_show_access(@show)
      respond_to do |format|
        if @show.update_attributes(params[:show])
          format.html { redirect_to @show, notice: 'Show was successfully updated.' }
        else
          format.html { render action: "edit" }
        end
      end
    end
  end

  def destroy
    @show = Show.find(params[:id])
    @show.destroy

    respond_to do |format|
      format.html { redirect_to shows_url }
    end
  end
  
  def search
    if params[:search_text] && params[:search_text] != ""
      match_term =  "%" + params[:search_text] + "%"
      @shows = Show.find(:all, :conditions => ["title like ?", match_term])
    end
  end
end
