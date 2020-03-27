class RemoveSectionIdFromLesson < ActiveRecord::Migration[6.0]
  def change

    remove_column :lessons, :section_id, :integer
  end
end
