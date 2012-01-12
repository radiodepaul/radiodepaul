# app/views/posts/index.rabl
collection @shows
attributes :id, :title, :genre
# child(:people) { attributes :first_last_name }