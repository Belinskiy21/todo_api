class RemoveColumnDeadlineFromTasks < ActiveRecord::Migration[5.1]
  def change
    remove_column :tasks, :deadline
  end
end
