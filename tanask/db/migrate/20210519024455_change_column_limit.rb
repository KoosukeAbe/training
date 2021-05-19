class ChangeColumnLimit < ActiveRecord::Migration[6.1]
  def change
    change_column :tasks, :name, :text, limit: 50
    change_column :tasks, :description, :text, limit: 100
  end
end
