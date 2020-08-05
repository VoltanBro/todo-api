# frozen_string_literal: true

module Api
  module V1
    class UsersController < ActionController::API
      def show
        @user = User.find(params[:id])
        render json: @user.name
      end

      private

      def user_params
        params.require(:user).permit(:name)
      end
    end
  end
end
