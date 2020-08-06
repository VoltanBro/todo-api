module Api
  module V1
    class ProjectsController < ApplicationController
      def new; end

      def create
        @project = User.find(params[:user_id]).projects.create(project_params)
        if @project.valid?
          render json: @project.name, status: 201
        else
          render json: 'The project with such name does already exist.'
        end
      end

      def update
        @user = User.find(params[:user_id])
        @project = @user.projects.find(params[:id])
        @project.update(project_params)
        render json: @project.name, status: 200
      end

      def destroy
        @user = User.find(params[:user_id])
        @project = @user.projects.find(params[:id])
        @project.destroy!
        render json: 'project was deleted', status: 204
      end

      private

      def project_params
        params.require(:project).permit(:name)
      end
    end
  end
end
