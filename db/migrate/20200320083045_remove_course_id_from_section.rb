class RemoveCourseIdFromSection < ActiveRecord::Migration[6.0]
  def change

    remove_column :sections, :course_id, :integer
  end
end
