class ChangeLessonsColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :lessons, :selector, :priority
    rename_column :lessons, :homework, :tell_homework
  end
end
