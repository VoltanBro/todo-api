require 'rails_helper'

RSpec.describe Project, type: :model do
  let!(:user) { create(:user, name: 'Manager') }
  let!(:project) { create(:project, name: 'TestProject', user_id: user.id) }
  let!(:project_invalid) { build(:project, name: 'TestProject', user_id: user.id) }

  it 'is valid with valid project`s name' do
    expect(project.valid?).to eq(true)
  end

  it "is invalid with duplicate project's name" do
    expect(project_invalid.valid?).to eq(false)
  end
end
