class AddExperienceCategoriesModel < ActiveRecord::Migration[7.0]
  def change
    create_table :experience_categories do |t|
      t.references :experience, foreign_key: true
      t.references :category, foreign_key: true
      t.timestamps
    end
  end
end
