class AddStatusToDeletedTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :deleted_tasks, :status_id, :integer
  end
end
