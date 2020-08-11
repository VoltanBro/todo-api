# frozen_string_literal: true

module Api
  module V1
    class RegistrationController < ApplicationController
      def create
        user = User.new(registration_params)
        if user.valid?
          user.save
          render json: { message: 'You’re successfully registered!' }, status: 201
        else
          render json: { error: user.errors }, status: 403
        end
      end

      private

      def registration_params
        params.require(:user).permit(:name, :password, :password_confirmation)
      end
    end
  end
end
