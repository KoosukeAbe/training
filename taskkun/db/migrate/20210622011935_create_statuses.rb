class CreateStatuses < ActiveRecord::Migration[6.1]
  def change
    create_table :statuses do |t|
      t.text :name, limit: 30, :null => false

      t.timestamps
    end
  end
end
