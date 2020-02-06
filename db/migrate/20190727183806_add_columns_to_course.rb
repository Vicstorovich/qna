class AddColumnsToCourse < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :type, :string, null: false, default: 'Course'
    add_column :courses, :number_hours_video, :integer
    add_column :courses, :number_hours_practice, :integer
    add_column :courses, :course_start_date, :date
    add_column :courses, :course_end_date, :date
  end
end
