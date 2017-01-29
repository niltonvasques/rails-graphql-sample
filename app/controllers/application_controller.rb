class ApplicationController < ActionController::API
  #self.responder = ApplicationResponder
  #respond_to :json

  # Rescue from any error with internal server code
  rescue_from StandardError do |e|
    logger.ap 'rescue_from api_controller'
    logger.ap e.message, :error
    logger.ap e.backtrace, :error
    render json: { error: e.message }, status: :internal_server_error
  end

  include AuthHelper
end
