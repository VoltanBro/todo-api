require 'rails_helper'

RSpec.describe "Projects", type: :request do
  let!(:password) { '12345678' }
  let!(:user) { create(:user) }
  let!(:project) { create(:project, user_id: user.id) }


  it 'Create new project' do
    byebug
    post "/api/v1/projects", params: { name: user.name, password: password }
    request.headers[JWTSessions.access_header] = @tokens[:access]
    expect(response).to be_successful
  end

end
