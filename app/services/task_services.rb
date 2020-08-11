# frozen_string_literal: true

class TaskServices
  def self.task_done(task)
    task.update(complited: true)
    task
  end
end
