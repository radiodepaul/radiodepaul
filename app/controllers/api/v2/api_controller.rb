class Api::V2::ApiController < ActionController::Base
  before_filter :cors_preflight_check
  after_filter :cors_set_access_control_headers

  def access_allowed?
    allowed_sites = [request.env['HTTP_ORIGIN']]
    allowed_sites.include?(request.env['HTTP_ORIGIN'])
  end

  def options
    head :ok
  end

  # For all responses in this controller, return the CORS access control headers.
  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS, DELETE'
    headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version, Content-Type'
    headers['Access-Control-Max-Age'] = "1728000"
  end

  # If this is a preflight OPTIONS request, then short-circuit the
  # request, return only the necessary headers and return an empty
  # text/plain.
  def cors_preflight_check
    if request.method == :options
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS, DELETE'
      headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version, Content-Type'
      headers['Access-Control-Max-Age'] = '1728000'
      render :text => '', :content_type => 'text/plain'
    end
  end
end
