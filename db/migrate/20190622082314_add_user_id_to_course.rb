class AddUserIdToCourse < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :user_id, :integer
    add_column :users, :active, :boolean, default: true
  end
end
