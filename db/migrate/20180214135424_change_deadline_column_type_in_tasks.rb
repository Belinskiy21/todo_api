class ChangeDeadlineColumnTypeInTasks < ActiveRecord::Migration[5.1]
  def change
    change_column :tasks, :deadline, 'deadline::timestamp without time zone'
  end
end
