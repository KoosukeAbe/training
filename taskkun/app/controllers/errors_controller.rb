class ErrorsController < ApplicationController
  def routing_error
    raise ActionController::RoutingError, params[:path]
  end
end
