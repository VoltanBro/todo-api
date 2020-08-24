class ChangeDeadlineToBeTimeStampsInTasks < ActiveRecord::Migration[6.0]
  def change
    change_column :tasks, :deadline, :timestamp
  end
end
