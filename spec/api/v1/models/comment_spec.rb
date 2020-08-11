# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  let!(:user) { create(:user) }
  let!(:project) { create(:project, user_id: user.id) }
  let!(:task) { create(:task, project_id: project.id, user_id: user.id) }
  let!(:comment) { create(:comment, project_id: project.id, user_id: user.id, task_id: task.id) }
  let!(:invalid_comment) do
    build(:comment, content: 'wrong', project_id: project.id, user_id: user.id,
                    task_id: task.id)
  end

  it 'create comment with valid content' do
    expect(comment.valid?).to eq(true)
  end

  it 'create comment with valid content' do
    expect(invalid_comment.valid?).to eq(false)
  end
end
