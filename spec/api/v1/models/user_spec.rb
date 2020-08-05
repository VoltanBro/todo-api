# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  before(:all) do
    @user = create(:user)
    @user2 = build(:user, name: 'Joe', password: '123_@asd',
                          password_confirmation: '123_@asd')
  end

  it 'is valid with valid attributes' do
    expect(@user).to be_valid
  end
  it 'is invalid with invalid attributes' do
    expect(@user2).to be_invalid
  end
end
