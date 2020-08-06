# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    name { 'TestTask' }
  end


  factory :project do
    name { 'MyProject' }
  end

  factory :user do
    name { 'Ivan' }
    password { 'ABcd1234' }
    password_confirmation { 'ABcd1234' }
  end
end
