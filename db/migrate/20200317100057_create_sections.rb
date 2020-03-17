class CreateSections < ActiveRecord::Migration[6.0]
  def change
    create_table :sections do |t|
      t.string :title
      t.integer :user_id
      t.integer :previous_id
      t.integer :next_id
      t.integer :course_id

      t.timestamps
    end
  end
end
