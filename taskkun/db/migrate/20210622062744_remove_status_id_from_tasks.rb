class RemoveStatusIdFromTasks < ActiveRecord::Migration[6.1]
  def change
    remove_column :tasks, :status_id, :integer
  end
end
