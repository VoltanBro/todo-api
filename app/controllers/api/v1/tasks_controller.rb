# frozen_string_literal: true

module Api
  module V1
    class TasksController < ApplicationController
      before_action :authorize_access_request!

      def new; end

      def create
        task = current_user.tasks.new(tasks_params)
        if task.save
          render jsonapi: task, status: 201
        else
          render jsonapi_errors: task.errors, status: 422
        end
      end

      def show
        task = current_user.tasks.find(params[:id])
        render jsonapi: task, status: 200
      end

      def show_tasks_by_project
        project = current_user.projects.find(params[:id])
        tasks = project.tasks.order('created_at')

        render jsonapi: tasks, status: 200
      end

      def task_complited
        task = current_user.tasks.find(params[:id])
        task = TaskServices.task_done(task)

        render jsonapi: task, status: 200
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

      def tasks_params
        params.require(:task).permit(:name, :complited, :deadline, :project_id,
                                     :user_id)
      end
    end
  end
end
