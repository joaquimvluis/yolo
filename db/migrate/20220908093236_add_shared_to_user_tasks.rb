class AddSharedToUserTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :user_tasks, :shared, :boolean, null: false, default: false
  end
end
