class CreateSectionContents < ActiveRecord::Migration[6.0]
  def change
    create_table :section_contents do |t|
      t.belongs_to :section, null: false, foreign_key: true
      t.belongs_to :lesson, null: false, foreign_key: true

      t.timestamps
    end
  end
end
