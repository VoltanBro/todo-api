# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  before(:all) do
    @user = create(:user)
    @user2 = build(:user, name: 'Joe', password: '123_@asd',
                          password_confirmation: '123_@asd')
    @user3 = build(:user, name: 'Ivan', password: 'abcd1234',
                          password_confirmation: 'abcd1234')
  end

  it 'is valid with valid attributes' do
    expect(@user).to be_valid
  end
  it 'is invalid with invalid attributes' do
    expect(@user2).to be_invalid
  end
  it 'is invalid with a duplicate user name' do
    @user3.valid?
    expect(@user3.errors[:name]).to include('has already been taken')
  end
end
