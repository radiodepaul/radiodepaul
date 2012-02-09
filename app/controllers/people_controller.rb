class PeopleController < ApplicationController
  # GET /people
  # GET /people.json
  
  respond_to :html, :xml, :json, :js
  
  def index
    @people = Person.find(:all, :order => 'first_name')

    respond_to do |format|
      format.html {
        if logged_in?
          render :html => @people
        end
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

    respond_to do |format|
      format.html {
        if logged_in?
          render :html => @person
        end
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
  
  
end
