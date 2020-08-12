# frozen_string_literal: true

module Api
  module V1
    class UsersController < ActionController
      before_action :authorize_access_request!

      def create
        user = User.new(user_params)
        if user.save
          render jsonapi: user, status: 201
        else
          render jsonapi_errors: user.errors, status: 422
        end
      end

      private

      def user_params
        params.permit(:name, :password, :password_confirmation)
      end
    end
  end
end
