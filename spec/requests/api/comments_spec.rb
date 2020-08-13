require 'swagger_helper'

RSpec.describe 'api/projects', type: :request do
  let(:user) { create(:user) }
  let(:project) { create(:project, user_id: user.id) }
  let!(:task) { create(:task, user_id: user.id, project_id: project.id) }
  let(:comment) { create(:comment, user_id: user.id, project_id: project.id, task_id: task.id) }
  let(:payload) { {user_id: user.id} }
  let(:session) { JWTSessions::Session.new(payload: payload) }
  let(:tokens) { session.login }
  let(:params) { {comment: {content: 'test_789_102312', project_id: project.id, task_id: task.id } } }
  let(:Authorization) { "Bearer #{tokens[:access]}" }

  path '/api/v1/comments' do
    post 'Create comment' do
      tags 'Comments'
      security [{bearerAuth: []}]
      consumes 'application/json'
      produces 'application/json'
      parameter name: :params, in: :body, type: :string, schema: {
          properties: {
              comment: {
                  properties: {
                      content: {type: :string},
                      project_id: {type: :string},
                      task_id: { type: :string }
                  }
              }
          }
      }
      response(201, 'OK') do
        run_test! do |response|
          json = JSON.parse(response.body)
        end
      end
    end
  end
end
