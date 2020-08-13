# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/registration', type: :request do
  let!(:name) { 'Ivanka' }
  let!(:password) { '12345678' }
          let(:params) { { name: 'Ivanka', password: password,
                       password_confirmation: password } }

  path '/api/v1/registration' do
    post 'Create user' do
      tags 'Users'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :params, in: :body, type: :string, schema: {
        properties: {
          name: { type: :string },
          password: { type: :string },
          password_confirmation: { type: :string }
        }
      }
      response(201, 'OK') do
        run_test!
      end
    end
  end
end
