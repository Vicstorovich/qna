class AddDraftToLessons < ActiveRecord::Migration[5.2]
  def change
    add_column :lessons, :draft, :boolean, null: false, default: false
  end
end
