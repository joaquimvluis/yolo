class RemoveCategoryIdFromExperiences < ActiveRecord::Migration[7.0]
  def change
    remove_column :experiences, :category_id, :references
  end
end
