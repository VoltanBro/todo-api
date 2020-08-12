# frozen_string_literal: true

module Api
  module V1
    class ProjectsController < ApplicationController
      before_action :authorize_access_request!

      def new; end

      # TODO need add validation for 'deadline'
      def create
        project = current_user.projects.new(project_params)
        if project.valid?
          project.save
          render jsonapi: project, status: 201
        else
          render jsonapi_errors: project, status: 422
        end
      end

      def show
        project = current_user.projects.find_by(id: params[:id])
        if project.nil?
          render jsonapi_errors: project, status: 404
        else
          render jsonapi: project, status: 200
        end
      end

      def update
        project = current_user.projects.find(params[:id])
        if project.update(project_params)
          render jsonapi: project, status: 200
        else
          render jsonapi_errors: project.errors, status: 403
        end
      end

      def destroy
        project = current_user.projects.find_by(id: params[:id])
        if project.nil?
          render json: { error: 'Project not found' }, status: 404
        else
          project.destroy
          render jsonapi: project, status: 200
        end
      end

      private

      def project_params
        params.require(:project).permit(:name, :deadline, :user_id)
      end
    end
  end
end
