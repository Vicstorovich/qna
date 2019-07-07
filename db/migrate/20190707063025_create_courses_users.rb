class CreateCoursesUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :course_users do |t|
      t.integer :course_id, null: false
      t.integer :user_id, null: false

      t.timestamps
    end

    add_index :course_users, [:user_id, :course_id], unique: true
  end
end
