module ErrorHandlers
    extend ActiveSupport::Concern
  
    included do
      rescue_from StandardError, with: :rescue500
      rescue_from Exception, with: :rescue500
      rescue_from ActionController::RoutingError, with: :rescue404
      rescue_from ActiveRecord::RecordNotFound, with: :rescue404
    end
  
    private
  
    def rescue404(_)
      render 'errors/404', status: :not_found
    end
  
    def rescue500(_)
      render '/errors/500', status: :internal_server_error
    end
end