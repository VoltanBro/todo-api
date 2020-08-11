# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    content { 'MyFirstComment' }
  end

  factory :user do
    name { 'Ivan' }
    password { '12345678' }
    password_confirmation { '12345678' }
  end

  factory :task do
    name { 'TestTask' }
    complited { false }
  end

  factory :project do
    name { 'MyProject' }
  end
end
