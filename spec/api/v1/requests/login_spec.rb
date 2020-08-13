# frozen_string_literal: true

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
          name: { type: :string },
          password: { type: :string }
        }
      }

      response(201, 'OK') do
        run_test! do |response|
          json = JSON.parse(response.body)
          expect(json).to include('access', 'csrf')
        end
        response(401, 'Unauthorized') do
          let(:params) { { name: user.name, password: 'wrongPassword' } }
          run_test!
        end
      end
    end
  end
end
