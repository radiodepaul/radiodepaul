class AwardOrganizationsController < ApplicationController
  before_filter :authenticate_person!
  allowed_roles = Array["Student General Manager"]
  before_filter :only => [:new, :create] { |c| c.validate_access allowed_roles }
  before_filter :isAdmin?, :only => [:destroy]
  # GET /award_organizations
  # GET /award_organizations.json
  def index
    @award_organizations = AwardOrganization.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @award_organizations }
    end
  end

  # GET /award_organizations/1
  # GET /award_organizations/1.json
  def show
    @award_organization = AwardOrganization.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @award_organization }
    end
  end

  # GET /award_organizations/new
  # GET /award_organizations/new.json
  def new
    @award_organization = AwardOrganization.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @award_organization }
    end
  end

  # GET /award_organizations/1/edit
  def edit
    @award_organization = AwardOrganization.find(params[:id])
  end

  # POST /award_organizations
  # POST /award_organizations.json
  def create
    @award_organization = AwardOrganization.new(params[:award_organization])

    respond_to do |format|
      if @award_organization.save
        format.html { redirect_to @award_organization, notice: 'Award organization was successfully created.' }
        format.json { render json: @award_organization, status: :created, location: @award_organization }
      else
        format.html { render action: "new" }
        format.json { render json: @award_organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /award_organizations/1
  # PUT /award_organizations/1.json
  def update
    @award_organization = AwardOrganization.find(params[:id])

    respond_to do |format|
      if @award_organization.update_attributes(params[:award_organization])
        format.html { redirect_to @award_organization, notice: 'Award organization was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @award_organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /award_organizations/1
  # DELETE /award_organizations/1.json
  def destroy
    @award_organization = AwardOrganization.find(params[:id])
    @award_organization.destroy

    respond_to do |format|
      format.html { redirect_to award_organizations_url }
      format.json { head :no_content }
    end
  end
end
