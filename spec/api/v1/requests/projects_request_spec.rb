require 'rails_helper'

RSpec.describe "Projects", type: :request do

    let!(:password) { '12345678' }
    let!(:user) { create(:user) }
    let!(:project) { create(:project, user_id: user.id) }
    let!(:user_params) { {user: {user: user.name, password: password}} }
end
