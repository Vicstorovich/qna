class AddShareKeyToLessons < ActiveRecord::Migration[5.2]
  def change
    add_column :lessons, :share_key, :string
  end
end
