# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { create(:user) }
  let!(:invalid_user) { build(:user, password: 'asdasd123123') }
  let!(:duplicate_user) { build(:user, name: 'Ivan') }

  it 'is valid with valid attributes' do
    expect(user).to be_valid
  end
  it 'is invalid with invalid attributes' do
    expect(invalid_user).to be_invalid
  end
  it 'is invalid with a duplicate user name' do
    duplicate_user.valid?
    expect(duplicate_user.errors[:name]).to include('This login is already registered. Please, log in.')
  end
end
