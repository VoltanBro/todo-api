# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.text :content
      t.belongs_to(:project, index: true, foreign_key: true)
      t.belongs_to(:task, index: true, foreign_key: true)
      t.belongs_to(:user, index: true, foreign_key: true)

      t.timestamps
    end
  end
end
