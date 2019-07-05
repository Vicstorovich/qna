class CreateHomeworks < ActiveRecord::Migration[5.2]
  def change
    create_table :homeworks do |t|
      t.text :body, null: false
      t.integer :lesson_id, null: false

      t.timestamps
    end
  end
end
