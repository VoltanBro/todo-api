module Api
  module V1
    class SessionsController < Devise::SessionsController

      private

      def respond_with(resource, _opts = {})
        render json: resource
      end

      def respond_to_on_destroy
        head :ok
      end
    end
  end
end
