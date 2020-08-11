# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_many :projects
  has_many :tasks
  has_many :comments
  validates :name, presence: { message: 'The field is required.'},
                   uniqueness: { message: 'This login is already registered. Please, log in.'},
                   length: { in: 3..50,
                             too_short: 'Username is too short. Minimum 3 characters',
                             too_long: 'Username is too long. Maximum 50 characters.' }
  validates :password, confirmation: { message: 'Password and Confirm password fields doesn’t match.'},
                       format: { with: /\A[a-zA-Z0-9]+\Z/ },
                       length: { is: 8, message: 'Password does not meet minimal requirements.
                         The length should be 8 characters, alphanumeric.' }
end
