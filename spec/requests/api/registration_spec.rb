require 'swagger_helper'

RSpec.describe 'api/registration', type: :request do
  let!(:name) { 'Ivanka' }
  let!(:password) { '12345678' }
  let!(:password_confirmation) { '12345678' }
  path '/api/v1/registration' do
    post 'Create user' do
      tags 'Users'
      consumes "application/json"
      produces "application/json"
      parameter name: :body, in: :body, schema: {
                properties: {
                    name: { type: :string },
                    password: { type: :string },
                    password_confirmation: { type: :string }
                },
                required: ['name', 'password', 'password_confirmation']
                 } 

      response(201, "OK") do
        let(:body) { { name: 'Ivanka', password: '12312312', password_confirmation: '12312312'} }
        run_test!
      end

      response(403, "Invalid params") do
        run_test!
      end
    end
  end
end
