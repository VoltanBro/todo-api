require 'swagger_helper'

RSpec.describe 'api/login', type: :request do
  let!(:user)   { create(:user) }
  let!(:params) { { name: user.name, password: '12345678' } } 

path '/api/v1/login' do
    post 'Login user' do
      tags 'Users'
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

      response(201, 'OK') do
        run_test!
      end
    end
  end
end