module Api
  module V1
    class TasksController < ApplicationController
      before_action :authorize_access_request!

      def new; end

      ### need fast fix -> Tasks don't create from json request
      def create
        task = current_user.tasks.create(tasks_params)

        render json: { task: { name: task.name } }, status: 201
      end

      def show
        task = current_user.tasks.find(params[:id])
        render json: { message: task.name }, status: 200
      end

      def show_tasks_by_project
        project = current_user.projects.find(params[:id])
        tasks = project.tasks.order("created_at")

        render json: tasks
      end

      def task_complited
        task = current_user.tasks.find(params[:id])
        task = TaskServices.task_done(task)

        render json: { message: "Task #{task.name} was complited" }
      end

      ###  fix -> Need to handle unavailable name
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
        params.require(:task).permit(:name, :project_id, :user_id)
      end
    end
  end
end
