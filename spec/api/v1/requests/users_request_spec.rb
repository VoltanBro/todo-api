require 'rails_helper'

RSpec.describe "User session", type: :request do
  let(:user) { create(:user) }

  it "logged user" do
    post "/api/v1/sign_in", params: { user: {name: user.name,
                                             password: user.password } }
    expect(response).to have_http_status('200')
  end
  end
