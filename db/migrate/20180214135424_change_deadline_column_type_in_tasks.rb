class ChangeDeadlineColumnTypeInTasks < ActiveRecord::Migration[5.1]
  def change
    change_column :tasks, :deadline, 'datetime without time zone'
  end
end
