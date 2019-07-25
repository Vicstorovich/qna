class CreateAdditionalCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :additional_courses do |t|
      t.string :number_hours_video, null: false, default: '0'
      t.string :number_hours_practice, null: false, default: '0'
      t.string :course_start_date, null: false, default: '0'
      t.string :course_end_date, null: false, default: '0'
      t.belongs_to :additionable, polymorphic: true, index: {name: "index_additional_on_additionable_type_and_additionable_id"}
      t.string :type

      t.timestamps
    end

    add_index(:additional_courses, [:type, :additionable_id], unique: true)
  end
end
