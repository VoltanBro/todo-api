# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/projects', type: :request do
  let!(:password)        { '12345678' }
  let!(:user)            { create(:user) }
  let!(:project_params)  { { project: { name: 'testProject', user_id: user.id } } }
  let!(:name)            { 'testProject' }
  let!(:access_token)    { "Bearer #{tokens[:access]}" }
  let!(:payload)         { { user_id: user.id } }
  let!(:session)         { JWTSessions::Session.new(payload: payload) }
  let!(:tokens)          { session.login }
  let!(:params)          { { project: { name: name } } }
  let!(:Authorization)   { "Bearer #{tokens[:access]}" }

  path '/api/v1/projects' do
    post 'Create project' do
      tags 'Projects'
      security [{ bearerAuth: [] }]
      consumes 'application/json'
      produces 'application/json'
      parameter name: :Authorization, in: :header, type: :string
      parameter name: :params, in: :body, type: :string, schema: {
        properties: {
          project: {
            properties: {
              name: { type: :string }
            }
          }
        }
      }

      response(201, 'OK') do
        run_test!
      end
    end
  end
end
