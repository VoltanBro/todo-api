require 'rails_helper'

RSpec.describe "User session", type: :request do
  let!(:password) { '12345678' }
  let!(:user) { create(:user) }


  it "Success login" do
    post "/api/v1/login", params: { name: user.name, password: password }
    expect(response).to be_successful
    expect(response.body).to include('access', 'access_expires_at', 'csrf', 'refresh', 'refresh_expires_at')
  end

  it "Unsuccessful logged" do
    post "/api/v1/login", params: { name: user.name, password: '123123' }
    expect(response).to have_http_status(:unauthorized)
  end
end
