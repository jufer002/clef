class RemoveUserFromSections < ActiveRecord::Migration[6.0]
  def change
    remove_column :sections, :user_id
  end
end
