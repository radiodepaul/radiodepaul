class AwardsController < ApplicationController
  load_and_authorize_resource

  def index
    @awards = Award.all(:order => 'year desc')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @awards }
    end
  end

  def show
    @award = Award.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @award }
    end
  end

  def new
    @award = Award.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @award }
    end
  end

  def edit
    @award = Award.find(params[:id])
  end

  def create
    @award = Award.new(params[:award])

    respond_to do |format|
      if @award.save
        format.html { redirect_to @award, notice: 'Award was successfully created.' }
        format.json { render json: @award, status: :created, location: @award }
      else
        format.html { render action: "new" }
        format.json { render json: @award.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @award = Award.find(params[:id])

    respond_to do |format|
      if @award.update_attributes(params[:award])
        format.html { redirect_to @award, notice: 'Award was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @award.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @award = Award.find(params[:id])
    @award.destroy

    respond_to do |format|
      format.html { redirect_to awards_url }
      format.json { head :no_content }
    end
  end
end
