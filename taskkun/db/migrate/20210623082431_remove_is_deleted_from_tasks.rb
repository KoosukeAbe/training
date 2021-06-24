class RemoveIsDeletedFromTasks < ActiveRecord::Migration[6.1]
  def change
    remove_column :tasks, :is_deleted, :boolean
  end
end
