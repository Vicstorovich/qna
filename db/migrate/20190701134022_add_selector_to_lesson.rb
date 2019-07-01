class AddSelectorToLesson < ActiveRecord::Migration[5.2]
  def change
    add_column :lessons, :selector, :integer, null: false, default: 0
  end
end
