# frozen_string_literal: true

module Api
  module V1
    class ProjectsController < ApplicationController
      before_action :authorize_access_request!

      def new; end

      def create
        project = current_user.projects.new(project_params)
        if project.valid?
          project.save
          render json: { message: project.name }, status: 201
        else
          render json: { "error": 'The project with such name does already exist.' }, status: 403
        end
     end

      def show
        project = current_user.projects.find(params[:id])

        render json: { message: project.name }, status: 200
      end

      def update
        project = current_user.projects.find(params[:id])
        if project.update(project_params).valid?
          render json: { message: project.name }, status: 200
        else
          render json: { message: 'bad name' }, status: 403
        end
      end

      ### Need fix it -> If project was already deleted, show status 404
      def destroy
        project = current_user.projects.find(params[:id])
        if project.nil?
          render json: { error: 'project was already deleted' }, status: 404
        else
          project.destroy
          render json: { message: 'project is deleted' }, status: 200
        end
      end

      private

      def project_params
        params.require(:project).permit(:name)
      end
    end
  end
end
