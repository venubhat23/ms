module ExceptionHandler
  extend ActiveSupport::Concern

  # Define custom error subclasses - rescue catches `StandardErrors`
  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end
  class ExpiredSignature < StandardError; end

  included do
    # Define custom handlers
    rescue_from ActiveRecord::RecordInvalid, with: :four_twenty_two
    rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
    rescue_from ExceptionHandler::MissingToken, with: :four_twenty_two
    rescue_from ExceptionHandler::InvalidToken, with: :four_twenty_two
    rescue_from ExceptionHandler::ExpiredSignature, with: :four_ninety_eight

    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({ message: e.message }, :not_found)
    end

    # Malformed JSON request bodies (e.g. a stale/broken client sending
    # `{"product_id":,"quantity":1}`) would otherwise blow up as an
    # unhandled 500 with a full backtrace. Respond the same way the rest
    # of the JSON endpoints do so callers get a parseable error instead.
    rescue_from ActionDispatch::Http::Parameters::ParseError do |e|
      if respond_to?(:json_response)
        json_response({ message: 'Invalid request.' }, :bad_request)
      else
        render json: { success: false, error: 'Invalid request.' }, status: :bad_request
      end
    end
  end

  private

  # JSON response with message; Status code 422 - unprocessable entity
  def four_twenty_two(e)
    if respond_to?(:json_response)
      json_response({ message: e.message }, :unprocessable_entity)
    else
      redirect_back(fallback_location: root_path, alert: e.message)
    end
  end

  # JSON response with message; Status code 401 - Unauthorized
  def unauthorized_request(e)
    if respond_to?(:json_response)
      json_response({ message: e.message }, :unauthorized)
    else
      redirect_back(fallback_location: root_path, alert: e.message)
    end
  end

  # JSON response with message; Status code 498 - Invalid token
  def four_ninety_eight(e)
    if respond_to?(:json_response)
      json_response({ message: e.message }, 498)
    else
      redirect_back(fallback_location: root_path, alert: e.message)
    end
  end
end