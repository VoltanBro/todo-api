# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/tasks', type: :request do
  let(:user)            { create(:user) }
  let(:project)         { create(:project, user_id: user.id) }
  let!(:task)      { create(:task, user_id: user.id, project_id: project.id) }
  let(:id)              { task.id }
  let(:name)            { task.name }
  let(:access_token)    { "Bearer #{tokens[:access]}" }
  let(:payload)         { { user_id: user.id } }
  let(:session)         { JWTSessions::Session.new(payload: payload) }
  let(:tokens)          { session.login }
  let(:params)          { { task: { name: 'test', project_id: project.id } } }
  let(:Authorization)   { "Bearer #{tokens[:access]}" }

  path '/api/v1/tasks' do
    post 'Create task' do
      tags 'Tasks'
      security [{ bearerAuth: [] }]
      consumes 'application/json'
      produces 'application/json'
      parameter name: :params, in: :body, type: :string, schema: {
        properties: {
          task: {
            properties: {
              name: { type: :string },
              project_id: { type: :string }
            }
          }
        }
      }

      response(201, 'OK') do
        run_test! do |response|
          json = JSON.parse(response.body)
          expect(json['data']['attributes']['name']).to eq('test')
        end
      end
      response(422, 'Invalid name') do
        let(:params)  { { task: { name: 't', project_id: project.id } } }
        run_test!
      end
    end
  end
  path '/api/v1/tasks/{id}' do
    get 'Show tasks by id' do
      tags 'Tasks'
      security [{ bearerAuth: [] }]
      consumes 'application/json'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response(200, 'OK') do
        run_test! do |response|
           json = JSON.parse(response.body)
           expect(json['data']['attributes']['name']).to include(task.name)
         end
      end
      response(404, 'Not found') do
        let(:id) { '9999999' }
        run_test!
      end
    end
  end
  path '/api/v1/tasks/{id}' do
    patch 'Update tasks by id' do
      tags 'Tasks'
      security [{ bearerAuth: [] }]
      consumes 'application/json'
      produces 'application/json'
      parameter name: :params, in: :body, type: :string, schema: {
        properties: {
          project: {
            properties: {
              name: { type: :string }
            }
          }
        }
      }
      parameter name: :id, in: :path, type: :string
      response(200, 'OK') do
        let(:params) { { task: { name: 'new_name', project_id: project.id } } }
         run_test!  do |response|
          json = JSON.parse(response.body)
          expect(json['data']['attributes']['name']).to eq('new_name')
        end
      end
      response(404, 'Not found') do
        let(:id) { '9999999' }
        run_test!
      end
    end
  end
  path '/api/v1/tasks/{id}' do
    delete 'Delete tasks by id' do
      tags 'Tasks'
      security [{ bearerAuth: [] }]
      consumes 'application/json'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string
      # response(204, 'OK') do
      #   run_test!
      # end
      response(404, 'Not found') do
        let(:id) { '9999999' }
        run_test!
      end
    end
  end
end
