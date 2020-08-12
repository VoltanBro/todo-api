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
        task = current_user.tasks.find_by(id: params[:id])
        if task.nil?
          render json: { error: 'Task not found' }, status: 404
        else
          render jsonapi: task, status: 200
        end
      end

      def show_tasks_by_project
        project = current_user.projects.find_by(id: params[:id])
        if project.nil?
          render json: { error: 'Tasks not found' }, status: 404
        else
          tasks = project.tasks.order('created_at')
          render jsonapi: tasks, status: 200
        end
      end

      def task_complited
        task = current_user.tasks.find_by(id: params[:id])
        if task.nil?
          render json: { error: 'Task not found' }, status: 404
        else
          task = TaskServices.task_done(task)
          render jsonapi: task, status: 200
        end
      end

      def update
        task = current_user.tasks.find_by(id: params[:id])
        if task.nil?
          render json: { error: 'Task not found' }, status: 404
        else
          task.update(tasks_params)
          render jsonapi: task, status: 200
        end
      end

      def destroy
        task = current_user.projects.find_by(id: params[:id])
        if task.nil?
          render json: { error: 'Task not found' }, status: 404
        else
          task.destroy
          render json: { message: 'Task was deleted' }, status: 204
        end
      end

      private

      def tasks_params
        params.require(:task).permit(:name, :complited, :project_id,
                                     :user_id)
      end
    end
  end
end
