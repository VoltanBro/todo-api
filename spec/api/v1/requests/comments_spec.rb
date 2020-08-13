require 'swagger_helper'

RSpec.describe 'api/projects', type: :request do
  let(:user) { create(:user) }
  let(:project) { create(:project, user_id: user.id) }
  let(:task) { create(:task, user_id: user.id, project_id: project.id) }
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
          expect(json['data']['attributes']['content']).to  eq(params[:comment][:content])
        end
      end
      response(422, 'UNPROCESSABLE ENTITY') do
        let(:params) { {comment: {content: 'short', project_id: project.id, task_id: task.id } } }
        run_test!
      end
    end
  end
  path '/api/v1/comments/{id}' do
    get 'Show comments by id' do
      tags 'Comments'
      security [{bearerAuth: []}]
      consumes 'application/json'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response(200, 'OK') do
        let(:id) { comment.id }
        run_test! do |response|
          json = JSON.parse(response.body)
          expect(json['data']['attributes']['content']).to  eq(comment.content)
        end
      end
      response(404, 'Not found') do
        let(:id) { '9999999' }
        run_test!
      end
    end
  end
  path '/api/v1/comments/{id}' do
    delete 'Delete comment by id' do
      tags 'Comments'
      security [{ bearerAuth: [] }]
      consumes 'application/json'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string
      response(204, 'OK') do
        let(:id) { comment.id }
        run_test!
      end
      response(404, 'Not found') do
        let(:id) { '9999999' }
        run_test!
      end
    end
  end
end
