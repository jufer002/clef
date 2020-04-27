class AddPositionToLessons < ActiveRecord::Migration[6.0]
  def change
    add_column :lessons, :position, :integer
  end
end
