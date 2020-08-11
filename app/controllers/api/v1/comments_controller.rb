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

          render json: { message: comment.content }, status: 201
        end
      end

      def show
        task = current_user.tasks.find(params[:id])
        render json: { message: task.name }, status: 200
      end

      def update
        task = current_user.tasks.find(params[:id])
        task.update(tasks_params)
        render json: { message: 'Task was updated' }, status: 200
      end

      def destroy
        task = current_user.projects.find(params[:id])
        task.destroy!
        render json: { message: 'Task was deleted' }, status: 204
      end

      private

      def comments_params
        params.require(:comment).permit(:content)
      end
    end
  end
end
