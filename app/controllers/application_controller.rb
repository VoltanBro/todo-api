# frozen_string_literal: true

class ApplicationController < ActionController::API
  # respond_to :json
  include JWTSessions::RailsAuthorization
  rescue_from JWTSessions::Errors::Unauthorized, with: :not_authorized

  private

  def current_user
    @current_user ||= User.find(payload['user_id'])
  end

  def not_authorized
    render json: { error: 'Not authorized' }, status: :unauthorized
  end

  def process_action(*args)
    super
  rescue ActionDispatch::Http::Parameters::ParseError => e
    render status: 400, json: { errors: [e.message] }
  end
end
