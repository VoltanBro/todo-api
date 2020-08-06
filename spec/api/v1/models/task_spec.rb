require 'rails_helper'

RSpec.describe Task, type: :model do
  let!(:user) { create(:user, name: 'Manager') }
  let!(:project) { create(:project, name: 'TestProject', user_id: user.id) }
  let!(:task) { create(:task, project_id: project.id) }
  let!(:invalid_task) { build(:task, project_id: project.id) }
  it 'should be valid with valid name' do
    expect(task.valid?).to eq(true)
  end

  it 'should be invalid with duplicate name' do
    expect(invalid_task.valid?).to eq(false)
  end
end
