class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :tag
      t.date :deadline
      t.string :penalty
      t.references :experience, null: false, foreign_key: true

      t.timestamps
    end
  end
end
