# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/registration', type: :request do
  let!(:name) { 'Ivanka' }
  let!(:password) { '12345678' }
  let(:body) { { name: 'Ivanka', password: password,
    password_confirmation: password } }

  path '/api/v1/registration' do
    post 'Create user' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :body, in: :body, type: :string
      response(201, 'OK') do

        run_test!
      end
    end
  end
end
