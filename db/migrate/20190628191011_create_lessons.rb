class CreateLessons < ActiveRecord::Migration[5.2]
  def change
    create_table :lessons do |t|
      t.string :title, null: false
      t.text :description
      t.text :conspectus
      t.text :homework
      t.string :image
      t.string :video

      t.integer :course_id, null: false

      t.timestamps
    end
  end
end
