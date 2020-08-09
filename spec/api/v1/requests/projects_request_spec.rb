# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'Projects', type: :request do
  let!(:password) { '12345678' }
  let!(:user) { create(:user) }
  let!(:project_params) { { project: { name: 'testProject', user_id: user.id } } }
  let(:access_token) { "Bearer #{@tokens[:access]}" }
  before do
    payload = { user_id: user.id }
    session = JWTSessions::Session.new(payload: payload)
    @tokens = session.login
  end

  it 'create new project' do
    headers = { Authorization: "Bearer #{@tokens[:access]}" }
    post '/api/v1/projects', params: project_params, headers: headers
    parsed_body = JSON.parse(response.body)
    expect(response).to be_successful
		expect(response).to have_http_status(:created)
    expect(parsed_body['project']['name']).to eq('testProject')
  end
end
