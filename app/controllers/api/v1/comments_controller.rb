# frozen_string_literal: true

module Api
  module V1
    class CommentsController < ApplicationController
      before_action :authorize_access_request!

      def new; end

      def create
        comment = current_user.comments.new(comments_params)
        if comment.valid?
          comment.save

          render jsonapi: comment, status: 201
        else

          render jsonapi_errors: comment.errors, status: 422
        end
      end

      def show
        comment = current_user.comments.find_by(id: params[:id])
        if comment.nil?

          render json: { error: 'Task not found' }, status: 404
        else

          render jsonapi: comment, status: 200
        end
      end

      def destroy
        comment = current_user.comments.find_by(id: params[:id])
        if comment.nil?

          render json: { error: 'Task not found' }, status: 404
        else
          comment.destroy!

          render jsonapi: comment, status: 204
        end
      end

      private

      def comments_params
        params.require(:comment).permit(:content, :project_id, :task_id, :user_id, :image)
      end
    end
  end
end
