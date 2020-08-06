# frozen_string_literal: true

FactoryBot.define do

  factory :project do
    name { 'MyProject' }
  end

  factory :user do
    name { 'Ivan' }
    password { 'ABcd1234' }
    password_confirmation { 'ABcd1234' }
  end
end
