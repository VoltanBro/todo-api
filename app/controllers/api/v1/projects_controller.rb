module Api
  module V1
    class ProjectsController < ApplicationController
      before_action :authorize_access_request!

      def new; end

      def create
        @project = current_user.projects.create(project_params)
        if @project.valid?
          render json: { message: @project.name }, status: 201
        else
          render json: {"error": "The project with such name does already exist."}, status: 422
        end
      end

      def show
        @project = current_user.projects.find(params[:id])

        render json: { message: @project.name }, status: 200
      end

      def update
        @project = current_user.projects.find(params[:id])
        @project.update(project_params)
        render json: { message: @project.name }, status: 200
      end

      def destroy
        @project = current_user.projects.find(params[:id])
        @project.destroy!
        render json: { message: 'project was deleted' }, status: 204
      end

      private

      def project_params
        params.require(:project).permit(:name)
      end
    end
  end
end
