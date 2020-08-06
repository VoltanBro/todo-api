require 'rails_helper'

RSpec.describe "User session", type: :request do
  let(:user) { create(:user) }

  it "logged in successfully" do
    post "/api/v1/sign_in", params: { user: { name: user.name,
                                              password: user.password } }
    expect(response).to have_http_status(:ok)
  end

  it "not logged in" do
    post "/api/v1/sign_in", params: { user: { name: user.name = 'Mst',
                                              password: user.password = '12312' } }
    expect(response).to have_http_status(:unauthorized)
  end
  end
