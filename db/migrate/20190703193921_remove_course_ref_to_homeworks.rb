class RemoveCourseRefToHomeworks < ActiveRecord::Migration[5.2]
  def change
    remove_column :homeworks, :course_id
  end
end
