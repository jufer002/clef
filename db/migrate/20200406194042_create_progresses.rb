class CreateProgresses < ActiveRecord::Migration[6.0]
  def change
    create_table :progresses do |t|
      t.bigint :user_id
      t.bigint :lesson_id

      t.timestamps
    end
  end
end
