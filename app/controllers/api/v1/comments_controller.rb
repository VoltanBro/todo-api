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

          render jsonapi_errors: comment.errors, status: 204
        end
      end

      def show
        task = current_user.tasks.find_by(id: params[:id])
        if task.nil?

          render json: { error: 'Task not found' }, status: 404
        else

          render json: { message: task.name }, status: 200
        end
      end

      def destroy
        task = current_user.projects.find_by(id: params[:id])
        if task.nil?

          render json: { error: 'Task not found' }, status: 404
        else
          task.destroy!

          render json: { message: 'Task was deleted' }, status: 204
        end
      end

      private

      def comments_params
        params.require(:comment).permit(:content, :project_id, :task_id)
      end
    end
  end
end
