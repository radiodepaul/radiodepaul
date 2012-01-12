# app/app.rb
get "/shows", :provides => [:json, :xml] do
  @shows = Post.order("id DESC")
  render "shows/index"
end