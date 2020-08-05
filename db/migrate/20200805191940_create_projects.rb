class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.text :title
      t.belongs_to(:user, index: true, foreign_key: true)

      t.timestamps
    end
  end
end
