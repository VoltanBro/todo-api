# frozen_string_literal: true

module Api
  module V1
    class LoginController < ApplicationController
      before_action :authorize_access_request!, only: [:destroy]
      before_action :authorize_refresh_request!, only: [:destroy_by_refresh]

      def create
        user = User.find_by!(name: params[:name])
        if user.authenticate(params[:password])
          payload = { user_id: user.id }
          session = JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true)
          render json: session.login
        else
          render json: { message: '“This login is already registered. Please, log in.' }, status: :unauthorized
        end
      end

      def destroy
        session = JWTSessions::Session.new(payload: payload)
        session.flush_by_access_payload
        render json: { message: 'User is logout' }, status: 200
      end

      def destroy_by_refresh
        session = JWTSessions::Session.new(payload: payload)
        session.flush_by_token(found_token)
        render json: :ok
      end
    end
  end
end
