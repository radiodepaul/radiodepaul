class Exits
  extend Garb::Model
  metrics :pageviews
  dimensions :page_path, :page_title
end
