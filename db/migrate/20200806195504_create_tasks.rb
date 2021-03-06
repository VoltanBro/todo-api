# frozen_string_literal: true

class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.text :name
      t.boolean :complited, default: false
      t.date :deadline

      t.belongs_to(:project, index: true, foreign_key: true)
      t.belongs_to(:user, index: true, foreign_key: true)

      t.timestamps
    end
  end
end
