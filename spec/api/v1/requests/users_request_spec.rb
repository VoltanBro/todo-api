require 'rails_helper'

RSpec.describe 'User session', type: :request do
  let!(:password) { '12345678' }
  let!(:user) { create(:user) }
  let!(:user_params) { {name: user.name, password: password, password_confirmation: password }}
  let!(:invalid_user_params) { {name: user.name, password: '123123', password_confirmation: '123123' }}


  it 'Success login' do
    post '/api/v1/login', params: user_params
    expect(response).to be_successful
    expect(response.body).to include('access', 'access_expires_at', 'csrf', 'refresh', 'refresh_expires_at')
  end

  it 'Unsuccessful login' do
    post '/api/v1/login', params: invalid_user_params
    expect(response).to have_http_status(:unauthorized)
  end
end
