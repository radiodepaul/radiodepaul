class NewsPostsController < ApplicationController
  before_filter :authenticate_person!, :except => [:getList, :getPost]
  allowed_roles = Array["Student General Manager"]
  before_filter :except => [:index, :getList, :getPost, :show] { |c| c.validate_access allowed_roles}
  before_filter :isAdmin?, :only => [:destroy]
  # GET /news_posts
  # GET /news_posts.json

  add_breadcrumb 'News Posts', :news_posts_path

  def index
    @news_posts = NewsPost.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @news_posts }
    end
  end

  # GET /news_posts/1
  # GET /news_posts/1.json
  def show
    @news_post = NewsPost.find(params[:id])
    @markdown_content = RDiscount.new(@news_post.content, :smart, :filter_html).to_html.html_safe

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @news_post }
    end
  end

  # GET /news_posts/new
  # GET /news_posts/new.json
  def new
    @news_post = NewsPost.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @news_post }
    end
  end

  # GET /news_posts/1/edit
  def edit
    @news_post = NewsPost.find(params[:id])
  end

  # POST /news_posts
  # POST /news_posts.json
  def create
    @news_post = NewsPost.new(params[:news_post])

    respond_to do |format|
      if @news_post.save
        format.html { redirect_to @news_post, notice: 'News post was successfully created.' }
        format.json { render json: @news_post, status: :created, location: @news_post }
      else
        format.html { render action: "new" }
        format.json { render json: @news_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /news_posts/1
  # PUT /news_posts/1.json
  def update
    @news_post = NewsPost.find(params[:id])

    respond_to do |format|
      if @news_post.update_attributes(params[:news_post])
        format.html { redirect_to @news_post, notice: 'News post was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @news_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /news_posts/1
  # DELETE /news_posts/1.json
  def destroy
    @news_post = NewsPost.find(params[:id])
    @news_post.destroy

    respond_to do |format|
      format.html { redirect_to news_posts_url }
      format.json { head :ok }
    end
  end

  def getList
    respond_to do |format|
      format.html { redirect_to pages_api_path}
      @news_posts = NewsPost.find(:all, :order => 'datetime_published DESC')
      format.js  { render :json => @news_posts, :callback => params[:callback] }
      format.json  { render :json => @news_posts }
    end
  end

  def getPost
    respond_to do |format|
      format.html { redirect_to pages_api_path}
      @news_post = NewsPost.find(params[:id])
      format.js  { render :json => @news_post, :callback => params[:callback] }
      format.json  { render :json => @news_post }
    end
  end



end
