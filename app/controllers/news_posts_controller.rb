class NewsPostsController < ApplicationController
  load_and_authorize_resource

  add_breadcrumb 'News Posts', :news_posts_path

  def index
    @news_posts = NewsPost.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @news_posts }
    end
  end

  def show
    @news_post = NewsPost.find(params[:id])
    @markdown_content = RDiscount.new(@news_post.content, :smart, :filter_html).to_html.html_safe

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @news_post }
    end
  end

  def new
    @news_post = NewsPost.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @news_post }
    end
  end

  def edit
    @news_post = NewsPost.find(params[:id])
  end

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

  def destroy
    @news_post = NewsPost.find(params[:id])
    @news_post.destroy

    respond_to do |format|
      format.html { redirect_to news_posts_url }
      format.json { head :ok }
    end
  end
end
