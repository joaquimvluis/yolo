class ChangingCompletedDefaultToFalse < ActiveRecord::Migration[7.0]
  def change
    change_column_default :user_tasks, :completed, false
  end
end
