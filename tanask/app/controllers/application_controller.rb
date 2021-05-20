class ApplicationController < ActionController::Base
  class Forbidden < ActionController::ActionControllerError; end

  class IpAddressRejected < ActionController::ActionControllerError; end

  include ErrorHandlers unless Rails.env.development?
end
