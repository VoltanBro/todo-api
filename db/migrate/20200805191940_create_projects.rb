# frozen_string_literal: true

class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.text :name
      t.date :deadline
      t.belongs_to(:user, index: true, foreign_key: true)

      t.timestamps
    end
  end
end
