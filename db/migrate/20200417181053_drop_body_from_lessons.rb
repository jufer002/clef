class DropBodyFromLessons < ActiveRecord::Migration[6.0]
  def change
    remove_column :lessons, :body
  end
end
