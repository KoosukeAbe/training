class ApplicationController < ActionController::Base
  include SessionsHelper
  rescue_from ActionController::RoutingError, with: :render_404
  rescue_from StandardError, with: :render_500

  def render_404
    logger.debug('404')
    render template: 'errors/error_404', status: 404, layout: 'application', content_type: 'text/html'
  end

  def render_500
    logger.debug('500')
    render template: 'errors/error_500', status: 500, layout: 'application', content_type: 'text/html'
  end
end
