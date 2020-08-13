# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/projects', type: :request do
  let(:password) { '12345678' }
  let(:user) { create(:user) }
  let!(:project) { create(:project, user_id: user.id) }
  let(:project_params) { {project: {name: 'testProject', user_id: user.id}} }
  let(:access_token) { "Bearer #{tokens[:access]}" }
  let(:payload) { {user_id: user.id} }
  let(:session) { JWTSessions::Session.new(payload: payload) }
  let(:tokens) { session.login }
  let(:id) { project.id }
  let(:create_project_params) { {project: {name: 'test_project'}} }
  let(:Authorization) { "Bearer #{tokens[:access]}" }

  path '/api/v1/projects' do
    post 'Create project' do
      tags 'Projects'
      security [{bearerAuth: []}]
      consumes 'application/json'
      produces 'application/json'
      parameter name: :create_project_params, in: :body, type: :string, schema: {
          properties: {
              project: {
                  properties: {
                      name: {type: :string}
                  }
              }
          }
      }

      response(201, 'OK') do
        run_test!
      end
      response(422, 'Unprocessable Entity ') do
        let(:create_project_params) { {project: {name: 'w'}} }
        run_test!
      end
    end
  end
  path '/api/v1/projects/{id}' do
    get 'Show project by id' do
      tags 'Projects'
      security [{bearerAuth: []}]
      consumes 'application/json'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response(200, 'OK') do
        run_test! do |response|
          json = JSON.parse(response.body)
          expect(json['data']['attributes']['name']).to include(project.name)
        end
      end
      response(404, 'Not found') do
        let(:id) { '9999999' }
        run_test!
      end
    end
  end
  path '/api/v1/projects/{id}' do
    patch 'Update project by id' do
      tags 'Projects'
      security [{bearerAuth: []}]
      consumes 'application/json'
      produces 'application/json'
      parameter name: :project_params, in: :body, type: :string, schema: {
          properties: {
              project: {
                  properties: {
                      name: {type: :string}
                  }
              }
          }
      }
      parameter name: :id, in: :path, type: :string
      response(200, 'OK') do
        let(:project_params) { {project: {name: 'new_name', user_id: user.id}} }
        run_test! do |response|
          json = JSON.parse(response.body)
          expect(json['data']['attributes']['name']).to include(project_params[:project][:name])
        end
      end
      response(404, 'Not found') do
        let(:id) { '9999999' }
        run_test!
      end
    end
  end
  path '/api/v1/projects/{id}' do
    delete 'Delete project by id' do
      tags 'Projects'
      security [{bearerAuth: []}]
      consumes 'application/json'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string
      response(200, 'OK') do
        let(:project_params) { {project: {name: 'new_name', user_id: user.id}} }
        run_test!
      end
      response(404, 'Not found') do
        let(:id) { '9999999' }
        run_test!
      end
    end
  end
end
