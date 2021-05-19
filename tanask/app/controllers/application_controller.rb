class ApplicationController < ActionController::Base
<<<<<<< HEAD
  class Forbidden < ActionController::ActionControllerError; end

  class IpAddressRejected < ActionController::ActionControllerError; end

  include ErrorHandlers unless Rails.env.development?
=======
>>>>>>> rocky
end
