class TasksController < ApplicationController
  def show
    @task = current_user.tasks.find(params[:id])
    render json: @task.name
  end
end
