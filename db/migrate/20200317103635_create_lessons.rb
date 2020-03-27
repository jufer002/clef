class CreateLessons < ActiveRecord::Migration[6.0]
  def change
    create_table :lessons do |t|
      t.string :title
      t.integer :user_id
      t.text :body
      t.integer :section_id

      t.timestamps
    end
  end
end
